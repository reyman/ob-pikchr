;;; ob-ditaa.el --- Babel Functions for pikchr        -*- lexical-binding: t; -*-

;; Copyright (C) 2020 Sebastien Rey-Coyrehourcq

;; Author: Sebastien Rey-Coyrehourcq

;;; License:
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this file.  If not, see <http://www.gnu.org/licenses/>.

;;; Code:
(require 'ob)
(require 'org-compat)

(defvar org-babel-default-header-args:pikchr
  '((:results . "file")
    (:exports . "results")
    (:svg . "--svg-only"))
  "Default arguments for evaluating a pikchr source block.")

(defcustom org-babel-pikchr-path
  (file-name-as-directory (expand-file-name "pikchr-latest"))
  "Path to the pikchr executable."
  :group 'org-babel
  :version "24.4"
  :package-version '(Org . "8.0")
  :type 'string
  )

(defcustom org-babel-pikchr-cmd "pikchr"
  "Executable to use when evaluating pikchr blocks."
  :group 'org-babel
  :type 'string)

(defun org-babel-execute:pikchr (body params)
  "Execute a block of pikchr code with org-babel.
This function is called by `org-babel-execute-src-block'."
  (let* ((out-file (or (cdr (assq :file params))
		       (error
			"pikchr code block requires :file header argument")))
         (svg (cdr (assq :svg params)))
	 (in-file (org-babel-temp-file "pikchr-"))
	 (cmd (concat org-babel-pikchr-path
                      org-babel-pikchr-cmd
		      " " svg
		      " " (org-babel-process-file-name in-file)
                      " > " (org-babel-process-file-name out-file)
		      )))
    (with-temp-file in-file (insert body))
    (message cmd) (shell-command cmd)
    nil))

(defun org-babel-prep-session:pikchr (_session _params)
  "Return an error because pikchr does not support sessions."
  (error "Pikchr does not support sessions"))

(provide 'ob-pikchr)

;;; ob-pikchr.el ends here
