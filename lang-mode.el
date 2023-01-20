;;; lang-mode.el --- A major mod for minecraft language files -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Björn Larsson
;;
;; Author: Björn Larsson <develop@bjornlarsson.net>
;; Maintainer: Björn Larsson <develop@bjornlarsson.net>
;; Created: December 19, 2022
;; Modified: December 19, 2022
;; Version: 0.0.1
;; Keywords: help 18n languages
;; Homepage: https://github.com/fuzzycode/lang-mode
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;; A major mode for working with Minecraft .lang files
;; Provides basic syntax highlighting
;;
;;; Code:

(eval-when-compile
  (require 'cl-lib))

(defconst lang-mode-syntax-table
  (let ((table (make-syntax-table)))
    ; Strings are inside ""
    (modify-syntax-entry ?\" "\"" table)

    ;; Double ## starts a comment and newline ends it
    (modify-syntax-entry ?# ". 12b" table)
    (modify-syntax-entry ?\n "> b" table)

    (modify-syntax-entry ?= ".")
    table))

(defconst lang-mode-font-lock-defaults
  '(("%[ds]" . 'font-lock-type-face)
    ("%[0-9]\$[ds]" . 'font-lock-type-face)
    ("%\.?[0-9*]f" . 'font-lock-type-face)))

(defun lang-mode-indent-line ()
  "Indentation handler for lang mode."
  (save-excursion
    (beginning-of-line)
    (indent-line-to 0)))

;;;###autoload
(define-derived-mode lang-mode fundamental-mode "Lang"
  "A major mode for editing Minecraft language files."
  :syntax-table lang-mode-syntax-table

  (setq font-lock-defaults '(lang-mode-font-lock-defaults))

  (setq-local indent-line-function #'lang-mode-indent-line)

  (setq-local comment-use-syntax t)
  (setq-local comment-start "##")
  (setq-local comment-start-skip "##+[\t ]*")
  (setq-local indent-tabs-mode t)

  ;; Enable address mode to make links clickable
  (goto-address-mode 1))


;;;###autoload
(add-to-list 'auto-mode-alist '("\\.lang$" . lang-mode))

(provide 'lang-mode)
;;; lang-mode.el ends here
