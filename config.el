;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Siwat Pruksapanya"
      user-mail-address "siwat.pru@gmail.com")

;; (setq doom-theme 'doom-one) // Default theme
;; (setq doom-theme 'doom-city-lights)
(setq doom-theme 'doom-nord-light)

(after! doom-theme
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic))

(set-face-attribute 'default nil
                    :family "Roboto Mono" :weight 'light :height 120)
(set-face-attribute 'bold nil
                    :family "Roboto Mono" :weight 'regular)
(set-face-attribute 'italic nil
                    :family "Roboto Mono" :weight 'semilight :slant 'italic)
(set-fontset-font t 'unicode
    (font-spec :name "Inconsolata Light" :size 14) nil)
(set-fontset-font t '(#xe000 . #xffdd)
    (font-spec :name "RobotoMono Nerd Font" :size 10) nil)

;; (setq doom-font (font-spec :family "FiraCode Nerd Font" :size 12 :weight 'medium))

;; you don't need to include all of them you can pick and mix
(setq! +ligatures-extra-symbols
  '(;; org
  :name          "»"
  :src_block     "»"
  :src_block_end "«"
  :quote         "“"
  :quote_end     "”"
  ;; Functional
  :lambda        "λ"
  :def           "ƒ"
  :composition   "∘"
  :map           "↦"
  ;; Flow
  :not           "￢"
  :in            "∈"
  :not-in        "∉"
  :and           "∧"
  :or            "∨"
  :for           "∀"
  :some          "∃"
  :return        "⟼"
  :yield         "⟻"
  ;; Other
  :union         "⋃"
  :intersect     "∩"
  :diff          "∖"
  :tuple         "⨂"
  :dot           "•"))

(setq display-line-numbers-type t)
(setq doom-themes-neotree-file-icons t)

(after! org
  (setq org-directory "~/org/"))
(use-package! org-roam-ui
    :after org-roam
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(add-hook 'org-mode-hook 'turn-on-auto-fill)

(after! org
    (setq org-roam-directory "~/Personal/roam"))

(use-package org-roam
    :config
    (setq org-roam-capture-templates
        '(("m" "main" plain "%?"
            :if-new (file+head "main/${slug}.org"
                                "#+title: ${title}\n")
            :immediate-finish t
            :unnarrowed t)
            ("r" "reference" plain "%?"
            :if-new(file+head "reference/${title}.org"
                            "#+title: ${title}\n")
            :immediate-finish t
            :unnarrowed t)
            ("n" "note" plain "%?"
            :if-new(file+head "note/${title}.org"
                            "#+title: ${title}\n")
            :immediate-finish t
            :unnarrowed t)
            ("a" "artile" plain "%?"
            :if-new (file+head "articles/${title}.org"
                                "#+title: ${title}\n#+filetags: :article:\n")
            :immediate-finish t
            :unnarrowed t)))

    (cl-defmethod org-roam-node-type ((node org-roam-node))
    "Return the TYPE of NODE."
    (condition-case nil
        (file-name-nondirectory
        (directory-file-name
            (file-name-directory
            (file-relative-name (org-roam-node-file node) org-roam-directory))))
        (error "")))

    (setq org-roam-node-display-template
        (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag))))

(use-package! websocket
    :after org-roam)

(after! org-journal
    (setq org-journal-dir "~/Personal/journal"
        org-journal-date-prefix "#+TITLE: "
        org-journal-date-format "%a, %Y %m %d"
        org-journal-file-format "%Y-%m-%d.org"
))

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

(setq smudge-oauth2-client-secret "a7b9633280864a0ea56854fd35c2af1b")
(setq smudge-oauth2-client-id "5cd793ea75864cd3ae42e7fbc16c3cda")

(beacon-mode 1)

(nyan-mode)
(after! nyan-mode
  (nyan-start-animation)
  (setq nyan-animate-nyancat t)
  (setq nyan-bar-length 20)
  (setq nyan-minimum-window-width 101))

(setq doom-modeline-major-mode-icon t)
(setq doom-modeline-major-mode-color-icon t)

;; Config for parrot
;; (define-key evil-normal-state-map (kbd "[r") 'parrot-rotate-prev-word-at-point)
;; (define-key evil-normal-state-map (kbd "]r") 'parrot-rotate-next-word-at-point)
;; (parrot-mode)

(emms-all)
(emms-default-players)

(setq auto-mode-alist
    (append '((".*\\.astro\\'" . js-jsx-mode))
        auto-mode-alist))

(use-package org-auto-tangle
  :load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory
  :defer t
  :hook (org-mode . org-auto-tangle-mode))
