                                        ; Allan Zhang's .emacs file

;;; Code:

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
                                        ; Offset the number by two spaces to work around some weird fringe glitch. See: http://stackoverflow.com/questions/4920210/what-causes-this-graphical-error-in-emacs-with-linum-mode-on-os-x
(setq linum-format "  %d ")

					; Workgroups for saving window configurations.
					; Note that is also a (workgroups-mode 1) at the bottom too

					; Undo Tree
(global-undo-tree-mode)
                                        ; Expand region
(global-set-key (kbd "C-=") 'er/expand-region)
                                        ; Expand Delete Mode
(delete-selection-mode 1)

					; IDO mode for better filename completion

(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

					; Flycheck global configs
(setq-default flycheck-flake8-maximum-line-length 500)

					; Switch-Window for easier window switching
(global-set-key (kbd "C-x o") 'switch-window)

					; Aggressive Indent Mode
(global-aggressive-indent-mode 1)

					; Smartparens
(smartparens-global-mode t)
(require 'smartparens-config)

					; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

					; Yas (Snippet and template support)
(yas-global-mode 1)


					;Changing key to ;;;; Depreciated!!! Might not need it anymore if company does not use tab for auto-complete
;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)

					; ESS for R and stuff


					; Org-Mode and RefTex set up
(require 'org)

(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name) (file-exists-p (buffer-file-name))
       (progn
					;enable auto-revert-mode to update reftex when bibtex file changes on disk
	 (global-auto-revert-mode t)
	 (reftex-parse-all)

                                        ; Add a custom reftex cite format to insert links
         (reftex-set-cite-format "** [[papers:%l][%2a %y]]: %t \n")
         )
       )
    (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  )

(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(setq org-link-abbrev-alist '(("papers" . "C:\\Users\\Allan Zhang\\Dropbox\\School Work\\Economic Papers\\%s.pdf")))

					; Suggested hotkeys. See documentation
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

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

					; Elpy for Python
(elpy-enable)

;; Changes default C-c C-c behavior so it sends the current line if nothing is selected instead of the entire buffer
(defun landis/send-line-or-region ()
  (interactive)
  (if (region-active-p)
      (call-interactively 'elpy-shell-send-region-or-buffer)
    (python-shell-send-string (elpy--region-without-indentation
                               (line-beginning-position)
                               (line-end-position)))))
(define-key elpy-mode-map (kbd "C-c C-c") 'landis/send-line-or-region)

					; Company Mode Configs
(require 'company-auctex)
(company-auctex-init)

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
 '(LaTeX-electric-left-right-brace nil)
 '(LaTeX-indent-level 4)
 '(LaTeX-item-indent 0)
 '(TeX-arg-right-insert-p t)
 '(TeX-command-list
   (quote
    (("TeX" "%(PDF)%(tex) %(file-line-error) %(extraopts) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (plain-tex-mode texinfo-mode ams-tex-mode)
      :help "Run plain TeX")
     ("LaTeX" "%'%l%(mode)%' %t" TeX-run-TeX nil
      (latex-mode doctex-mode)
      :help "Run LaTeX")
     ("Makeinfo" "makeinfo %(extraopts) %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with Info output")
     ("Makeinfo HTML" "makeinfo %(extraopts) --html %t" TeX-run-compile nil
      (texinfo-mode)
      :help "Run Makeinfo with HTML output")
     ("AmSTeX" "%(PDF)amstex %(extraopts) %`%S%(PDFout)%(mode)%' %t" TeX-run-TeX nil
      (ams-tex-mode)
      :help "Run AMSTeX")
     ("ConTeXt" "texexec --once --texutil %(extraopts) %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt once")
     ("ConTeXt Full" "texexec %(extraopts) %(execopts)%t" TeX-run-TeX nil
      (context-mode)
      :help "Run ConTeXt until completion")
     ("BibTeX" "bibtex %s" TeX-run-BibTeX nil t :help "Run BibTeX")
     ("Biber" "biber %s" TeX-run-Biber nil t :help "Run Biber")
     ("View" "%V" TeX-run-discard-or-function t t :help "Run Viewer")
     ("Print" "%p" TeX-run-command t t :help "Print the file")
     ("Queue" "%q" TeX-run-background nil t :help "View the printer queue" :visible TeX-queue-command)
     ("File" "%(o?)dvips %d -o %f " TeX-run-command t t :help "Generate PostScript file")
     ("Index" "makeindex %s" TeX-run-command nil t :help "Create index file")
     ("Xindy" "texindy %s" TeX-run-command nil t :help "Run xindy to create index file")
     ("Check" "lacheck %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for correctness")
     ("ChkTeX" "chktex -v6 %s" TeX-run-compile nil
      (latex-mode)
      :help "Check LaTeX file for common mistakes")
     ("Spell" "(TeX-ispell-document \"\")" TeX-run-function nil t :help "Spell-check the document")
     ("Clean" "TeX-clean" TeX-run-function nil t :help "Delete generated intermediate files")
     ("Clean All" "(TeX-clean t)" TeX-run-function nil t :help "Delete generated intermediate and output files")
     ("Other" "" TeX-run-command t t :help "Run an arbitrary command"))))
 '(TeX-source-correlate-mode t)
 '(aggressive-indent-excluded-modes
   (quote
    (bibtex-mode coffee-mode conf-mode Custom-mode diff-mode dos-mode erc-mode jabber-chat-mode haml-mode haskell-mode makefile-mode makefile-gmake-mode minibuffer-inactive-mode netcmd-mode python-mode sass-mode slim-mode special-mode shell-mode snippet-mode eshell-mode tabulated-list-mode term-mode TeX-output-mode text-mode yaml-mode ein:ml)))
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auto-image-file-mode t)
 '(color-theme-is-cumulative t)
 '(color-theme-is-global t)
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (monokai)))
 '(custom-safe-themes
   (quote
    ("628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "4e262566c3d57706c70e403d440146a5440de056dfaeb3062f004da1711d83fc" default)))
 '(delete-by-moving-to-trash t)
 '(elpy-modules
   (quote
    (elpy-module-company elpy-module-eldoc elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-yasnippet elpy-module-sane-defaults)))
 '(ess-eval-visibly (quote nowait))
 '(ess-smart-S-assign-key "<")
 '(ess-swv-pdflatex-commands (quote ("pdflatex")))
 '(ess-swv-processor (quote knitr))
 '(flycheck-check-syntax-automatically (quote (save mode-enabled)))
 '(flycheck-checkers
   (quote
    (ada-gnat asciidoc c/c++-clang c/c++-gcc c/c++-cppcheck cfengine chef-foodcritic coffee coffee-coffeelint coq css-csslint d-dmd elixir emacs-lisp emacs-lisp-checkdoc erlang eruby-erubis fortran-gfortran go-gofmt go-golint go-vet go-build go-test go-errcheck haml handlebars haskell-ghc haskell-hlint html-tidy javascript-jshint javascript-eslint javascript-gjslint json-jsonlint less lua perl perl-perlcritic php php-phpmd php-phpcs puppet-parser puppet-lint python-flake8 python-pylint python-pycompile r-lintr racket rpm-rpmlint rst rst-sphinx ruby-rubocop ruby-rubylint ruby ruby-jruby rust sass scala scala-scalastyle scss sh-bash sh-posix-dash sh-posix-bash sh-zsh sh-shellcheck slim tex-chktex tex-lacheck texinfo verilog-verilator xml-xmlstarlet xml-xmllint yaml-jsyaml yaml-ruby)))
 '(flycheck-disabled-checkers (quote (python-pylint python-flake8)))
 '(flycheck-display-errors-delay 0.5)
 '(flycheck-flake8-maximum-line-length 2000)
 '(flycheck-flake8rc "C:\\HOME\\.config\\flake8")
 '(flycheck-highlighting-mode (quote lines))
 '(flycheck-idle-change-delay 1.5)
 '(flycheck-python-flake8-executable nil)
 '(flycheck-python-pylint-executable "c:\\Python27\\Scripts\\pylint.exe")
 '(flycheck-tex-chktex-executable
   "\"C:\\Program Files (x86)\\MiKTeX 2.9\\miktex\\bin\\chktex.exe\"")
 '(flyspell-default-dictionary "en_US")
 '(global-aggressive-indent-mode nil)
 '(global-visual-line-mode t)
 '(global-whitespace-mode nil)
 '(highlight-changes-colors ("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   (("#49483E" . 0)
    ("#67930F" . 20)
    ("#349B8D" . 30)
    ("#21889B" . 50)
    ("#968B26" . 60)
    ("#A45E0A" . 70)
    ("#A41F99" . 85)
    ("#49483E" . 100)))
 '(indent-tabs-mode nil)
 '(inferior-julia-program-name "C:\\Julia-0.3.7\\bin\\julia-debug.exe")
 '(ispell-dictionary "en_US")
 '(ispell-extra-args nil)
 '(ispell-highlight-face (quote flyspell-incorrect))
 '(ispell-local-dictionary "en_US")
 '(ispell-local-dictionary-alist
   (quote
    (("en_US" "\"[[:alpha:]]\"" "\"[^[:alpha:]]\"" "\"[']\"" t
      ("-d en_US")
      "~tex" iso-8859-1))))
 '(ispell-program-name "c:\\Misc Programs\\hunspell\\bin\\hunspell.exe")
 '(magit-diff-use-overlays nil)
 '(monokai-high-contrast-mode-line t)
 '(org-agenda-files
   (quote
    ("c:/Users/Allan Zhang/Dropbox/School Work/Economic Papers/EconomicPapers.org")))
 '(org-directory "C:\\Users\\Allan Zhang\\Dropbox\\Emacs\\orgy")
 '(org-log-done (quote time))
 '(org-startup-indented t)
 '(preview-default-document-pt 12)
 '(preview-gs-command "c:\\Program Files (x86)\\gs\\gs8.71\\bin\\gswin32c.exe")
 '(preview-gs-options
   (quote
    ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4")))
 '(preview-scale-function 1.5)
 '(python-check-command "flake8")
 '(python-indent-guess-indent-offset nil)
 '(python-shell-interpreter "C:\\Python27\\python.exe")
 '(python-shell-interpreter-args "-i C:\\Python27\\Scripts\\ipython.exe")
 '(recentf-auto-cleanup (quote mode))
 '(recentf-max-saved-items 400)
 '(recentf-mode t)
 '(reftex-cite-punctuation (quote (", " " \\& " " et al.")))
 '(show-smartparens-global-mode t)
 '(tab-always-indent t)
 '(tool-bar-mode nil)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0"))
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
 '(whitespace-empty ((t nil)))
 '(whitespace-hspace ((t (:background "gray12" :foreground "#969896"))))
 '(whitespace-indentation ((t nil)))
 '(whitespace-line ((t nil)))
 '(whitespace-space ((t (:background "gray12" :foreground "#969896"))))
 '(whitespace-space-after-tab ((t nil)))
 '(whitespace-space-before-tab ((t nil)))
 '(whitespace-tab ((t nil)))
 '(whitespace-trailing ((t nil))))

					; Enabling workgroups mode
(workgroups-mode 1)
