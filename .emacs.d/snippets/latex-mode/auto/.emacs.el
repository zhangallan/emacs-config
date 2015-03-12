(TeX-add-style-hook
 ".emacs"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("nag" "l2tabu" "orthodox") ("fullpage" "cm") ("hyperref" "colorlinks=true" "urlcolor=blue" "linkcolor=Green" "citecolor=RedViolet")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "nag"
    "article"
    "art10"
    "setspace"
    "fullpage"
    "titling"
    "microtype"
    "amsmath"
    "amsthm"
    "amssymb"
    "graphicx"
    "hyperref"
    "booktabs"
    "enumitem"
    "lmodern")
   (TeX-add-symbols
    "e")
   (LaTeX-add-environments
    "prop"
    "thm"
    "lemma"
    "cor")))

