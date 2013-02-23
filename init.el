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
(add-to-list 'load-path "~/.emacs.d/plugins/js2-mode")
(add-to-list 'load-path "~/.emacs.d/plugins/paredit")
(add-to-list 'load-path "~/.emacs.d/plugins/distel/elisp")
;;;;;;;;;;;;;;;;;;;;;
;; disable toolbar ;;
;;;;;;;;;;;;;;;;;;;;;
(tool-bar-mode -1)

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
(setq frame-title-format (list user-login-name "@" system-name " : %b %+ %f"))

;;;;;;;;;;;;;;;;;;;;;;;;
;; enable color theme ;;
;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'color-theme)
(require 'color-theme-solarized)
;; (color-theme-solarized-light)
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
(when (load "myflymake" t)
  (progn (checker-bee-init)
	 ;; (setq flymake-log-level 3)
	 ))


(add-hook 'find-file-hook 'flymake-find-file-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; add flymake errors to minibuffer ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
   (let ((help (get-char-property (point) 'help-echo)))
    (if help (message "%s" help)))))

(add-hook 'post-command-hook 'my-flymake-show-help)


;;;;;;;;;;;;;;;;;;;;;
;; mark ipdb lines ;;
;;;;;;;;;;;;;;;;;;;;;
;(load 'utils)
;(add-hook 'python-mode-hook 'mark-ipdb)

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

;;;;;;;;;;;;;;;;;;;;;;
;; enable narrowing ;;
;;;;;;;;;;;;;;;;;;;;;;
(put 'narrow-to-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; enable paren matching mode ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(show-paren-mode t)

;;;;;;;;;;;;;;;;;;;;
;; enable paredit ;;
;;;;;;;;;;;;;;;;;;;;
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))

(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
(defun override-slime-repl-bindings-with-paredit ()
  (define-key slime-repl-mode-map
    (read-kbd-macro paredit-backward-delete-key) nil))
(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

;;;;;;;;;;;;;;;;;;
;; enable slime ;;
;;;;;;;;;;;;;;;;;;
;; enable slime with slime helper
(condition-case ex ; if slime-helper is not installed do not give an error
    (progn
      (load (expand-file-name "~/quicklisp/slime-helper.el"))

      ;; Replace "sbcl" with the path to your implementation
      (setq inferior-lisp-program "sbcl")

      ;; connect slime automatically
      ;; when slime-mode is opened
      (defun cliki:start-slime ()
	(unless (slime-connected-p)
	  (save-excursion (slime))))
      ;; add full linking set
      (add-hook 'slime-mode-hook 'cliki:start-slime))
  ('error (message "slime could not be loaded")))

;;;;;;;;;;;;;;;;;;;;;;;;
;; enable erlang-mode ;;
;;;;;;;;;;;;;;;;;;;;;;;;

(setq erlang-root-dir "/usr/lib/erlang")
(setq load-path (cons  "/usr/lib/erlang/lib/tools-2.6.8/emacs" load-path))
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))

(add-to-list
   'load-path
       (car (file-expand-wildcards "/usr/lib/erlang/lib/tools-*/emacs")))

(require 'erlang-start)
(require 'erlang-flymake)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set regular-expression mode to string ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 're-builder)
(reb-change-syntax 'string)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Disable the splash screen ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-splash-screen t)

;;;;;;;;;;;;;;;;
;; add distel ;;
;;;;;;;;;;;;;;;;
(require 'distel)
(distel-setup)

;; http://bc.tech.coop/blog/070528.html
;; Some Erlang customizations
;; (add-hook 'erlang-mode-hook
;; 	  (lambda ()
;; 	    ;; when starting an Erlang shell in Emacs, default in the node name
;; 	    (setq inferior-erlang-machine-options '("-sname" "emacs"))
;; 	    ;; add Erlang functions to an imenu menu
;; 	    (imenu-add-to-menubar "imenu")))

;; ;; A number of the erlang-extended-mode key bindings are useful in the shell too
;; (defconst distel-shell-keys
;;   '(("\C-\M-i"   erl-complete)
;;     ("\M-?"      erl-complete)	
;;     ("\M-."      erl-find-source-under-point)
;;     ("\M-,"      erl-find-source-unwind) 
;;     ("\M-*"      erl-find-source-unwind) 
;;     )
;;   "Additional keys to bind when in Erlang shell.")

;; (add-hook 'erlang-shell-mode-hook
;; 	  (lambda ()
;; 	    ;; add some Distel bindings to the Erlang shell
;; 	    (dolist (spec distel-shell-keys)
;; 	      (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

;; (defun get-erlang-app-dir ()
;;   (let* ((src-path (file-name-directory (buffer-file-name)))
;;      (pos (string-match "/src/" src-path)))
;;     (if pos
;;     (substring src-path 0 (+ 1 pos))
;;       src-path)))

;; (setq erlang-flymake-get-code-path-dirs-function
;;       (lambda ()
;;     (concat (get-erlang-app-dir) "ebin")))

;; (setq erlang-flymake-get-code-include-dirs-function
;;       (lambda ()
;;     (concat (get-erlang-app-dir) "include")))
