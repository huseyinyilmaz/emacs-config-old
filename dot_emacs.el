;;;;;;;;;;;;;;;;;;;;;;;;;
;; configure load-path ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'load-path "~/.emacs.d/plugins/autocomplete")
(add-to-list 'load-path "~/.emacs.d/plugins/color-theme-6.6.0")
(add-to-list 'load-path "~/.emacs.d/plugins/emacs-color-theme-solarized")
(add-to-list 'load-path "~/.emacs.d/plugins/flymake-python")
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(add-to-list 'load-path "~/.emacs.d/plugins/autopair")

;;;;;;;;;;;;;;;;;;;;;
;; enable ido mode ;;
;;;;;;;;;;;;;;;;;;;;;
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t) ;; enable fuzzy matching

;;;;;;;;;;;;;;;;;;;;;;;;;
;; enable autocomplete ;;
;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/autocomlete/ac-dict/")
(ac-config-default)

;;;;;;;;;;;;;;;;;;;;;;
;; set window title ;;
;;;;;;;;;;;;;;;;;;;;;;
(setq frame-title-format '("Emacs @ " system-name ": %b %+%+ %f"))

;;;;;;;;;;;;;;;;;;;;;;;;
;; enable color theme ;;
;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'color-theme)
(require 'color-theme-solarized)
(color-theme-solarized-dark)
;(color-theme-initialize)
;(color-theme-hober)


;;;;;;;;;;;;;;;;;;;;;
;; enable js2 mode ;;
;;;;;;;;;;;;;;;;;;;;;
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; enable flymake-python ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (load "flymake" t)
  (defun flymake-pylint-init (&optional trigger-type)
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-with-folder-structure))
	   (local-file (file-relative-name
			temp-file
			(file-name-directory buffer-file-name)))
	   (options (when trigger-type (list "--trigger-type" trigger-type))))
      (list "~/.emacs.d/plugins/flymake-python/pyflymake.py" (append options (list local-file)))))
  
  (add-to-list 'flymake-allowed-file-name-masks
	       '("\\.py\\'" flymake-pylint-init)))


(add-hook 'find-file-hook 'flymake-find-file-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add flymake errors to minibuffer ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
   (let ((help (get-char-property (point) 'help-echo)))
    (if help (message "%s" help)))))

(add-hook 'post-command-hook 'my-flymake-show-help)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; disable flymake for html ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(delete '("\\.html?\\'" flymake-xml-init) flymake-allowed-file-name-masks)

;;;;;;;;;;;;;;;;
;; add nxhtml ;;
;;;;;;;;;;;;;;;;
(load "~/.emacs.d/plugins/nxhtml/autostart.el")

;;;;;;;;;;;;;;;;;;;;;;
;; enable yasnippet ;;
;;;;;;;;;;;;;;;;;;;;;;
(require 'yasnippet) ;; not yasnippet-bundle
(yas/global-mode 1)
(yas/load-directory "~/.emacs.d/snippets")

;;;;;;;;;;;;;;;;;;;;;;;
;; enable linum mode ;;
;;;;;;;;;;;;;;;;;;;;;;;
(global-linum-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; enable autopair mode ;;
;;;;;;;;;;;;;;;;;;;;;;;;;; 
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers

;;;;;;;;;;;;;;;;;;;;;;
;; enable narrowing ;;
;;;;;;;;;;;;;;;;;;;;;;
(put 'narrow-to-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; enable paren matching mode ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(show-paren-mode t)

;;;;;;;;;;;;;;;;;;
;; enable slime ;;
;;;;;;;;;;;;;;;;;;
(setq inferior-lisp-program "sbcl")

(add-to-list 'load-path "~/.emacs.d/plugins/slime")
(add-to-list 'load-path "~/.emacs.d/plugins/slime/contrib")

(require 'slime-autoloads)
(slime-setup '(slime-fancy))
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
