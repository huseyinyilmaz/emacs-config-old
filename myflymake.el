(load "flymake" t)  

(defun check-file (target-file)

  )


(defun checker-bee-init ()
  ;;flyemake-init-code
  (defun flymake-lint-init (&optional trigger-type)
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-with-folder-structure))
	   (local-file (file-truename
			(file-relative-name
			 temp-file
			 (file-name-directory buffer-file-name))))
	   (options (when trigger-type (list "--debug" "--trigger-type" trigger-type)))
	   (result (list "~/.emacs.d/plugins/flymake-python/pyflymake.py"
			 (append options (list local-file)))))
      (message "%s" result)
      result
      ))

  (defun flytest ()
    (message "Other fun"))

  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-lint-init flytest))
  )
