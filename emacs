;; do not delete this line -- osu-cis-.emacs-version $Revision: 1.4 $
(require 'cl)  ;; for ignore-errors
;(setq debug-on-error t)
(add-to-list 'load-path "~/.emacs-macros/")

;; make sure global font lock goes on for Java mode
;;(add-hook 'java-mode-hook 'turn-on-font-lock)
;; Never mind, set it for all modes that support it

(global-font-lock-mode t)
(iswitchb-mode t)
(setq confirm-kill-emacs 'yes-or-no-p)
(setq line-move-visual nil)

;; Save and restore set of open files across restarting emacs
;; http://stackoverflow.com/questions/803812/emacs-reopen-buffers-from-last-session-on-startup
;(desktop-save-mode 1)

;; page-up then page-down returns to original cursor position
;; http://superuser.com/questions/184340/emacs-how-to-return-to-last-position-after-scroll-page-up-down
(setq scroll-preserve-screen-position t)

;; From http://www.emacswiki.org/emacs/DuplicateLines
(require 'uniquify)  ; for nice duplicate buffer names
(defun uniquify-all-lines-region (start end)
  "Find duplicate lines in region START to END keeping first occurrence."
  (interactive "*r")
  (save-excursion
    (let ((end (copy-marker end)))
      (while
          (progn
            (goto-char start)
            (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
        (replace-match "\\1\n\\2")))))
(defun uniquify-all-lines-buffer ()
  "Delete duplicate lines in buffer and keep first occurrence."
  (interactive "*")
  (uniquify-all-lines-region (point-min) (point-max)))


;; Make emacs 22 splash screen act like it does in emacs 21
(when (> (length command-line-args) 1)
  (setq inhibit-splash-screen t))

;; Don't wait for window manager to start up
;; http://ubuntuforums.org/archive/index.php/t-183638.html
(modify-frame-parameters nil '((wait-for-wm . nil)))

(add-hook 'java-mode-hook (lambda () 
			    (c-toggle-hungry-state 1)
			    (setq c-basic-offset 2)))
(add-hook 'perl-mode-hook (lambda () (setq perl-indent-level 2)))
;(add-hook 'python-mode-hook
;          (lambda () 
;            (setq-default py-indent-offset 2)
;            (setq-default python-indent 2)))
(add-to-list 'auto-mode-alist '("\\.wsgi\\'" . python-mode))

(add-hook 'tex-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
;(require 'reftex)
;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)

(global-set-key [f3] 'fill-region)
(global-set-key [f4] 'query-replace)
(global-set-key [f5] 'goto-line)
;(global-set-key [f6] 'c-fill-paragraph)
(global-set-key [f7] 'replace-regexp)
(global-set-key [f8] 'flyspell-buffer)
(global-set-key [f9] 'hscroll-mode)
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; Make sure C-c C-c is always comment-region (doesn't seem to work)
;(global-set-key "\C-c\C-c" 'comment-region)
;(add-hook 'find-file-hook
;          (global-set-key "\C-c\C-c" 'comment-region))
;(add-hook 'after-change-major-mode-hook
;          (global-set-key "\C-c\C-c" 'comment-region))

(tool-bar-mode -1)
(menu-bar-mode -1)

(setq-default mouse-yank-at-point 1)
(setq-default indent-tabs-mode nil)


;; Org Mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-off-auto-fill)
(add-hook 'org-mode-hook 'toggle-truncate-lines)
(setq org-log-done t)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq browse-url-browser-function 'browse-url-generic browse-url-generic-program "gnome-open")

;; Remember mode
(setq org-remember-templates
  '(("Tasks" ?t "** TODO %?\n  %i\n  %a" "~/doc/org/gtd.org" "Inbox")
    ("Appointments" ?a "** Appointment: %?\n%^T\n%i\n  %a" 
     "~/doc/org/gtd.org" "Inbox")))
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(eval-after-load 'remember
  '(add-hook 'remember-mode-hook 'org-remember-apply-template))
(global-set-key (kbd "C-c r") 'remember)


(setq tex-dvi-view-command
      (if (eq window-system 'x) "xdvi" "dvi2tty * | cat -s"))

;; ;; Set font for a frame opened with M-x new-frame
;; (setq default-frame-alist
;;      (append default-frame-alist
;;              '((font . "fixed")
;;                ;(background-color . "black")
;;                ;(foreground-color . "white")
;;                )))

;; (defun set-my-font (frame)
;;   "Set's my favorite font in a frame"
;;   (select-frame frame)
;; ;;  (set-frame-font "-adobe-courier-medium-r-normal--*-120-*-*-m-*-iso8859-1"))
;;   (set-frame-font -*-fixed-medium-r-normal-*-16-*-*-*-*-*-fontset-standard))
;; (add-hook 'after-make-frame-functions 'set-my-font)
;; ;;(set-frame-font "-adobe-courier-medium-r-normal--*-120-*-*-m-*-iso8859-1")

;(set-default-font "fixed")
;; (set-default-font "-misc-fixed-medium-r-normal--13-120-75-75-c-70-iso8859-1")
;(set-default-font "-misc-fixed-medium-r-semicondensed--13-*-100-100-c-60-iso8859-1")

;; 6.004 classware, jsim mode
(autoload 'jsim-mode "~/work/6.004/jsim" nil t)
(add-to-list 'auto-mode-alist '("\.jsim$" . jsim-mode))
(add-hook 'jsim-mode-hook 'turn-on-font-lock)

;; Matlab major mode
;(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(add-to-list 'auto-mode-alist '("\\.m\\'" . octave-mode))
;(setq matlab-indent-function t)
;(setq matlab-shell-command "matlab")

;; Use cperl-mode instead of perl-mode
(add-to-list 'auto-mode-alist '("\\.pl\\'" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.pm\\'" . cperl-mode))

;; CSound
(autoload 'csound-orc-mode "csound-orc"
          "Csound Orchestra major mode." t)
(autoload 'csound-sco-mode "csound-sco"
          "Csound Score major mode." t)
(add-to-list 'auto-mode-alist '("\.orc$" . csound-orc-mode))
(add-to-list 'auto-mode-alist '("\.sco$" . csound-sco-mode))


;; Word Count
(defun word-count nil "Count words in buffer" (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))

(setq scroll-step 2)
;(setq scroll-margin 4)

;; Mutt editing in text mode
(add-to-list 'auto-mode-alist '("mutt" . text-mode))

;; Use text mode for dot graph files
(add-to-list 'auto-mode-alist '("\.dot$" . text-mode))

(put 'downcase-region 'disabled nil)

;; for editing R files
(setq ess-fancy-comments nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-indent-environment-list
   (quote
    (("verbatim" current-indentation)
     ("verbatim*" current-indentation)
     ("tabular")
     ("tabular*")
     ("align")
     ("align*")
     ("array")
     ("eqnarray")
     ("eqnarray*")
     ("displaymath")
     ("equation")
     ("equation*")
     ("picture")
     ("tabbing")
     ("table")
     ("table*"))))
 '(desktop-save-mode t)
 '(load-home-init-file t t)
 '(safe-local-variable-values (quote ((TeX-PDF-mode . t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flyspell-duplicate ((t (:background "orange"))))
 '(flyspell-incorrect ((t (:background "Red1")))))


;; For editing ruby on rails .rhtml files
(autoload 'two-mode-mode "two-mode-mode"
          "Run two modes at the same time" t)
(autoload 'rhtml-minor-mode "rhtml-minor-mode"
          "Minor mode for editing ruby on rails .rhtml files" t)

(defun rhtml-modes ()
  (two-mode-mode)
  (rhtml-minor-mode))

(add-to-list 'auto-mode-alist '("\\.rhtml$" . rhtml-modes))
(add-to-list 'auto-mode-alist '("\\.rjs$" . ruby-mode))


;;;;; Org mode ;;;;;;
;; Set to the location of your Org files on your local system
(setq org-directory "~/doc/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/doc/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/MobileOrg")

(setq org-mobile-files '("~/doc/org/gtd.org" 
                         "~/doc/org/work.org" 
                         "~/doc/org/personal.org"))


;---------------------------------------------------------------------------
; Un-fillers: from http://interglacial.com/~sburke/pub/emacs/sburke_dot_emacs.config

(defun unfill-paragraph ()
  "Unfill the current paragraph."
  (interactive) (with-unfilling 'fill-paragraph))
(defalias 'unwrap-paragraph 'unfill-paragraph)

(defun unfill-region ()
  "Unfill the current region."
  (interactive) (with-unfilling 'fill-region))
(defalias 'unwrap-region 'unfill-region)

(defun unfill-individual-paragraphs ()
  "Unfill individual paragraphs in the current region."
  (interactive) (with-unfilling 'fill-individual-paragraphs))
(defalias 'unwrap-individual-paragraphs 'unfill-individual-paragraphs)

(defun with-unfilling (fn)
  (let ((fill-column 10000000)) (call-interactively fn)))


(put 'upcase-region 'disabled nil)

(put 'narrow-to-region 'disabled nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Latex AUCTeX and Reftex stuff
;;; from: http://piotrkazmierczak.com/blog/emacs-as-the-ultimate-latex-editor

;; AUCTeX
(setq TeX-auto-save t) 
(setq TeX-parse-self t) 
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

;; Flymake
;(require 'flymake)
;(defun flymake-get-tex-args (file-name) (list "pdflatex" 
;    (list "-file-line-error" "-draftmode" "-interaction=nonstopmode" file-name)))
;(add-hook 'LaTeX-mode-hook 'flymake-mode)

;; ispell
(setq ispell-program-name "aspell") 
    ; could be ispell as well, depending on your preferences 
(setq ispell-dictionary "english") 

;(add-hook 'LaTeX-mode-hook 'flyspell-mode) 
;(add-hook 'LaTeX-mode-hook 'flyspell-buffer)

;; from http://stackoverflow.com/questions/21279118/cant-properly-disable-flyspell-in-org-mode
(add-hook 'flyspell-mode-hook 'flyspell-buffer)
(add-hook 'text-mode-hook (lambda ()
                            (when (not (equal major-mode 'org-mode))
                              (flyspell-mode t))))

;; Outline mode
(defun turn-on-outline-minor-mode () (outline-minor-mode 1))
(add-hook 'LaTeX-mode-hook 'turn-on-outline-minor-mode) 
(add-hook 'latex-mode-hook 'turn-on-outline-minor-mode) 
(setq outline-minor-mode-prefix "\C-c\C-o")

;; Reftex
(ignore-errors
 (require 'tex-site)
 (autoload 'reftex-mode "reftex" "RefTeX Minor Mode" t)
 (autoload 'turn-on-reftex "reftex" "RefTeX Minor Mode" nil)
 (autoload 'reftex-citation "reftex-cite" "Make citation" nil)
 (autoload 'reftex-index-phrase-mode "reftex-index" "Phrase Mode" t)
 (add-hook 'latex-mode-hook 'turn-on-reftex) ; with Emacs latex mode
 ;; (add-hook 'reftex-load-hook 'imenu-add-menubar-index)
 (add-hook 'LaTeX-mode-hook 'turn-on-reftex))

(setq LaTeX-eqnarray-label "eq"
      LaTeX-equation-label "eq"
      LaTeX-figure-label "fig"
      LaTeX-table-label "tab"
      LaTeX-myChapter-label "chap"
      TeX-auto-save t
      TeX-newline-function 'reindent-then-newline-and-indent
      TeX-parse-self t
      TeX-style-path
      '("style/" "auto/"
        "/usr/share/emacs21/site-lisp/auctex/style/"
        "/var/lib/auctex/emacs21/"
        "/usr/local/share/emacs/site-lisp/auctex/style/")
      LaTeX-section-hook
      '(LaTeX-section-heading
        LaTeX-section-title
        LaTeX-section-toc
        LaTeX-section-section
        LaTeX-section-label))


;; Python debugging
;; from: http://scipy-lectures.github.io/advanced/debugging/index.html
(defun pyflakes-thisfile () (interactive)
       (compile (format "pyflakes %s" (buffer-file-name)))
)

(define-minor-mode pyflakes-mode
    "Toggle pyflakes mode.
    With no argument, this command toggles the mode.
    Non-null prefix argument turns on the mode.
    Null prefix argument turns off the mode."
    ;; The initial value.
    nil
    ;; The indicator for the mode line.
    " Pyflakes"
    ;; The minor mode bindings.
    '( ([f6] . pyflakes-thisfile) )
)

;; (add-hook 'python-mode-hook (lambda () (pyflakes-mode t)))

;; (when (load "flymake" t)
;;         (defun flymake-pyflakes-init ()
;;         (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                             'flymake-create-temp-inplace))
;;             (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;             (list "pyflakes" (list local-file))))

;;         (add-to-list 'flymake-allowed-file-name-masks
;;                 '("\\.py\\'" flymake-pyflakes-init)))

;; (add-hook 'find-file-hook 'flymake-find-file-hook)

