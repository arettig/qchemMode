; MODE FOR EDITING Q-CHEM INPUT FILES

(setq section-list '("$comment" "$molecule" "$rem" "$end"))
(setq rem-list ())

(with-temp-buffer
  (insert-file-contents "~/repos/qchem/qchem/include/rem_values.h")
  (while (search-forward-regexp "#define" nil t)
    (forward-char)
    (setq rem-list (cons (format "%s" (thing-at-point 'sexp)) rem-list))
    ))

(with-temp-buffer
  (insert-file-contents "~/repos/qchem/qchem/include/rem_input.h")
  (while (search-forward-regexp "#define" nil t)
    (forward-char)
    (setq rem-list (cons (format "%s" (thing-at-point 'sexp)) rem-list))
    ))




(setq section-list-regexp "\$[^[:space:]]+") ; (regexp-opt section-list 'words))
(setq rem-list-regexp (regexp-opt rem-list 'words))
(setq comment-regexp "\$comment[^$]+\$end")
(setq qchem-font-lock-keywords `((,comment-regexp . font-lock-comment-face)
				 (,section-list-regexp . font-lock-keyword-face)
				 (,rem-list-regexp . font-lock-type-face)))




(define-derived-mode qchem-mode nil "qchem-mode"
  "Highlighting for qchem input files"

  (setq font-lock-defaults '((qchem-font-lock-keywords) nil t))

  (setq comment-start "!")
  (setq comment-end "\n"))

(provide 'qchem-mode)
