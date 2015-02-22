                                        ; Allan Zhang's .emacs file

                                        ; Initializing Packages
(package-initialize)
(setq package-enable-at-startup nil)

                                        ;User Details
(setq user-full-name "Allan Zhang")
(setq user-mail-address "allan.tao.zhang@gmail.com")

; Makes all yes or no prompts to y or n
(defalias 'yes-or-no-p 'y-or-n-p)

                                        ; Line numbers
(global-linum-mode 1)

					; IDO mode for better filename completion
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

                                        ; Color Theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-charcoal-black)

					; Changing backup directory to avoid clutter
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

					; Recentf - For easily getting recent files
(require 'recentf)
(global-set-key (kbd "C-x C-r") 'ido-recentf-open) ;; get rid of `find-file-read-only' and replace it with something more useful.

(recentf-mode t) ;; enable recent files mode.

(setq recentf-max-saved-items 50) ; 50 files ought to be enough.

;; Regex to ignore some files
(add-to-list 'recentf-exclude "\\.el\\'")
(add-to-list 'recentf-exclude "\\.log\\'")
(add-to-list 'recentf-exclude "\\.out\\'")
(add-to-list 'recentf-exclude "\\.aux\\'")

(defun ido-recentf-open ()
  "Use `ido-completing-read' to \\[find-file] a recent file"
  (interactive)
  (if (find-file (ido-completing-read "Find recent file: " recentf-list))
      (message "Opening file...")
    (message "Aborting")))


                                        ; AUCTeX Config
(setq TeX-auto-save t) ; Enable parse on save
(setq TeX-parse-self t) ; Enable parse on load

; Getting additional package repos

 (load "package")
 (package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))


 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CUSTOM STUFF. DON'T TOUCH ;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-electric-left-right-brace t)
 '(TeX-arg-right-insert-p t)
 '(TeX-source-correlate-mode t)
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auto-image-file-mode t)
 '(color-theme-is-cumulative t)
 '(color-theme-is-global t)
 '(custom-enabled-themes nil)
 '(global-visual-line-mode t)
 '(global-whitespace-mode t)
 '(indent-tabs-mode t)
 '(preview-default-document-pt 12)
 '(preview-gs-command "c:\\Program Files (x86)\\gs\\gs8.71\\bin\\gswin32c.exe")
 '(preview-gs-options
   (quote
    ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4")))
 '(preview-scale-function 1.5)
 '(recentf-auto-cleanup (quote mode))
 '(recentf-max-saved-items 200)
 '(recentf-mode t)
 '(tab-always-indent t)
 '(whitespace-action nil)
 '(whitespace-display-mappings
   (quote
    ((space-mark 32
		 [183]
		 [46])
     (space-mark 160
		 [164]
		 [95])
     (tab-mark 9
	       [187 9]
	       [92 9])))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-hspace ((t nil)))
 '(whitespace-indentation ((t nil)))
 '(whitespace-line ((t nil)))
 '(whitespace-space ((t nil)))
 '(whitespace-space-after-tab ((t nil)))
 '(whitespace-space-before-tab ((t nil)))
 '(whitespace-tab ((t nil)))
 '(whitespace-trailing ((t nil))))
