;;; This is cribbed and modified from
;; https://raw.githubusercontent.com/bazelbuild/emacs-bazel-mode/master/bazel-build.el
;; Original attribution below. Major changes include
;; - mbzl support -
;; - read target actually figures out which target the current buffer belongs to
;;
;; bazel-build.el --- Emacs utilities for using Bazel -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2018 Google LLC
;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at
;;
;;      http://www.apache.org/licenses/LICENSE-2.0
;;
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.
;;
;;; Commentary:
;;
;; This package provides commands to build and run code using Bazel.
;; It defines interactive commands which perform completion of available Bazel
;; targets:
;;   - `bazel-build'
;;   - `bazel-run'
;;   - `bazel-test'
;;   - `bzl-gen'
;;
;;; Code:

(defcustom bazel-command-bin nil
       "Command used to invoke bazel"
       :type 'string
       :require 'bazel-build)

(setq bazel-command-bin "mbzl")

(defun bazel-command (cmd)
  "Returns the full string of the command to run"
  (concat bazel-command-bin " " cmd))

(defun bazel-build (target)
  "Build a Bazel TARGET."
  (interactive (list (bazel-build--read-target "bazel build ")))
  (bazel-build--run-bazel-command "build" target))

(defun bazel-run (target)
  "Build and run a Bazel TARGET."
  (interactive (list (bazel-build--read-target "bazel run ")))
  (bazel-build--run-bazel-command "run" target))

;; Dropbox specific
(defun bzl-gen (target)
  "bzl gen current"
  ;; pass disable-query-for-target to just use current dir
  (interactive (list (bazel-build--read-target "bzl gen " nil t)))
  (bazel-build--run-bazel-command "gen" target))

(defun bazel-test (target)
  "Build and run a Bazel test TARGET."
  (interactive (list (bazel-build--read-target "bazel test " (quote bazel-build--test-target-search-query))))
  (bazel-build--run-bazel-command "test" target))

(defun bazel-build--run-bazel-command (command target)
  "Run Bazel tool with given COMMAND, e.g. build or run, on the given TARGET."
  (compile
   (mapconcat #'shell-quote-argument (list bazel-command-bin command target) " ")))

(defun bazel-build--filter-targets-from-query-output (output)
  (string-join
   (seq-filter  (lambda (s) (string-prefix-p "//" s))
                (split-string output "\n")) " "))

(defun bazel-build--test-target-search-query (package target)
  (concat "kind(services_internal_test, rdeps(" package "/...," file-target "))"))

(defun bazel-build--default-target-search-query (package target)
  (concat "same_pkg_direct_rdeps(" file-target ")"))

(defun bazel-build--query-owner-target (package file-target query-func)
  "For a proposed file target determine the owning target"
  (let* ((command
         (mapconcat
          #'shell-quote-argument (list bazel-command-bin "query"
                           (funcall query-func package file-target)) " ")))

    (progn
      (message (concat "Running bazel query: " command))
      (shell-command-to-string command))))


(defun bazel-build--read-target (prompt &optional query-func disable-query-for-target-b)
  "Read a Bazel build target from the minibuffer.  PROMPT is a read-only prompt."
  (let* ((file-name (buffer-file-name))
         (error-check (if file-name nil
                        (user-error "Buffer isn't associated with a file")))
         (workspace-root
          (or (bazel-build--find-workspace-root file-name)
              (user-error "Not in a Bazel workspace.  No WORKSPACE file found")))
         (package-name
          (or (bazel-build--extract-package-name file-name workspace-root)
              (user-error "Not in a Bazel package.  No BUILD file found")))
         (initial-input (concat "//" package-name))
         ;; bazel query understand pwd relative target labels.
         (file-target
          (file-name-nondirectory file-name))
         (owner-target
          (if (and file-target (not disable-query-for-target-b))
              (bazel-build--filter-targets-from-query-output
               (bazel-build--query-owner-target initial-input file-target
                                                (if query-func query-func (quote bazel-build--default-target-search-query))))
            nil)))
    (read-string prompt (or owner-target initial-input))))

(defun bazel-build--find-workspace-root (file-name)
  "Find the root of the Bazel workspace containing FILE-NAME.
If FILE-NAME is not in a Bazel workspace, return nil."
  (locate-dominating-file file-name "WORKSPACE"))

(defun bazel-build--extract-package-name (file-name workspace-root)
  "Return the nearest Bazel package for FILE-NAME under WORKSPACE-ROOT.
If FILE-NAME is not in a Bazel package, return nil."
  (let ((build-file-directory
         (cl-some (lambda (build-name)
                    (locate-dominating-file file-name build-name))
                  '("BUILD.bazel" "BUILD"))))
    (cond ((not build-file-directory) nil)
          ((file-equal-p workspace-root build-file-directory) "")
          ((file-in-directory-p build-file-directory workspace-root)
           (let ((package-name
                  (file-relative-name build-file-directory workspace-root)))
             ;; Only return package-name if we can confirm it is the local
             ;; relative file name of a BUILD file.
             (and package-name
                  (not (file-remote-p package-name))
                  (not (file-name-absolute-p package-name))
                  (directory-file-name package-name))))
          (t nil))))

(provide 'bazel-build)

;;; bazel-build.el ends here
