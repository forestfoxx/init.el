(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")))
(package-initialize)
 
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'disaster)
(require 'x86-lookup)
(require 'lsp-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(kaolin-eclipse))
 '(custom-safe-themes
   '("d2ab3d4f005a9ad4fb789a8f65606c72f30ce9d281a9e42da55f7f4b9ef5bfc6" "c20728f5c0cb50972b50c929b004a7496d3f2e2ded387bf870f89da25793bb44" "daa27dcbe26a280a9425ee90dc7458d85bd540482b93e9fa94d4f43327128077" "788121c96b7a9b99a6f35e53b7c154991f4880bb0046a80330bb904c1a85e275" "3c7a784b90f7abebb213869a21e84da462c26a1fda7e5bd0ffebf6ba12dbd041" "b5fab52f16546a15f171e6bd450ff11f2a9e20e5ac7ec10fa38a14bb0c67b9ab" "6128465c3d56c2630732d98a3d1c2438c76a2f296f3c795ebda534d62bb8a0e3" "74e2ed63173b47d6dc9a82a9a8a6a9048d89760df18bc7033c5f91ff4d083e37" "9cd57dd6d61cdf4f6aef3102c4cc2cfc04f5884d4f40b2c90a866c9b6267f2b3" "0170347031e5dfa93813765bc4ef9269a5e357c0be01febfa3ae5e5fcb351f09" "2ce76d65a813fae8cfee5c207f46f2a256bac69dacbb096051a7a8651aa252b0" "c95813797eb70f520f9245b349ff087600e2bd211a681c7a5602d039c91a6428" "a131602c676b904a5509fff82649a639061bf948a5205327e0f5d1559e04f5ed" "b95f61aa5f8a54d494a219fcde9049e23e3396459a224631e1719effcb981dbd" "e266d44fa3b75406394b979a3addc9b7f202348099cfde69e74ee6432f781336" "06ed754b259cb54c30c658502f843937ff19f8b53597ac28577ec33bb084fa52" "249e100de137f516d56bcf2e98c1e3f9e1e8a6dce50726c974fa6838fbfcec6b" "5a00018936fa1df1cd9d54bee02c8a64eafac941453ab48394e2ec2c498b834a" default))
 '(doom-modeline-minor-modes t)
 '(package-selected-packages
   '(yaml-mode projectile go-mode dslide expand-region riscv-mode dirvish doom-modeline verilog-ts-mode magit company lsp-mode kaolin-themes x86-lookup pdf-tools rmsbolt helm disaster)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(use-package helm
  :ensure t
  :diminish helm-mode
  :config
  (progn
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
          helm-yas-display-key-on-candidate t
          helm-quick-update t
          helm-M-x-requires-pattern nil
          helm-ff-skip-boring-files t)
    (helm-mode))
  :bind (("C-c h" . helm-mini)
         ("C-h a" . helm-apropos)
         ("C-x C-b" . helm-buffers-list)
         ("C-x b" . helm-buffers-list)
         ("C-x C-f" . helm-find-files)
         ("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
         ("C-x c y" . helm-yas-complete)
         ("C-x c Y" . helm-yas-create-snippet-on-region)
         ("C-x c b" . my/helm-do-grep-book-notes)
         ("C-x c SPC" . helm-all-mark-rings)))
(pdf-tools-install) 
(setq x86-lookup-pdf "/path/to/intel/manual")
 (use-package kaolin-themes
   :config
   (load-theme 'kaolin-eclipse t))
(add-hook 'after-init-hook 'global-company-mode)
(add-to-list 'default-frame-alist
	     '(font ."Hack Nerd Font-12:weight=bold:slant=italic"))
(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
	(elisp "https://github.com/Wilfred/tree-sitter-elisp")
	(make "https://github.com/alemuller/tree-sitter-make")
	(c "https://github.com/tree-sitter/tree-sitter-c")
	(verilog "https://github.com/tree-sitter/tree-sitter-verilog")
	(asm "https://github.com/RubixDev/tree-sitter-asm")))
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode))
(use-package nerd-icons
  ;; :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
  )
(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  :custom
  (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
   '(("h" "~/"                          "Home")
     ("d" "~/Downloads/"                "Downloads")
     ("m" "/mnt/"                       "Drives")
     ("t" "~/.local/share/Trash/files/" "TrashCan")))
  :config
  (dirvish-peek-mode) ; Preview files in minibuffer
  (dirvish-side-follow-mode) ; similar to `treemacs-follow-mode'
  (setq dirvish-mode-line-format
        '(:left (sort symlink) :right (omit yank index)))
  (setq dirvish-attributes
        '(nerd-icons file-time file-size collapse subtree-state vc-state git-msg))
  (setq delete-by-moving-to-trash t)
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")
)
(setq dired-mouse-drag-files t)                   ; added in Emacs 29
(setq mouse-drag-and-drop-region-cross-program t) ; added in Emacs 29
(setq mouse-1-click-follows-link t)
(define-key dirvish-mode-map (kbd "<mouse-1>") 'dirvish-subtree-toggle-or-open)
(define-key dirvish-mode-map (kbd "<mouse-2>") 'dired-mouse-find-file-other-window)
(define-key dirvish-mode-map (kbd "<mouse-3>") 'dired-mouse-find-file)
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)
;; Must do this so the agenda knows where to look for my files
(setq org-agenda-files '("~/org"))
;; When a TODO is set to a done state, record a timestamp
(setq org-log-done 'time)
;; Follow the links
(setq org-return-follows-link  t)
;; Associate all org files with org mode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; Make the indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)
(use-package expand-region
  :ensure t
  :bind
  (("C-." . 'er/expand-region)
   ("C-," . 'er/contract-region)))
(use-package dslide)
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(asm-mode . "asm"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection "asm-lsp")
    :major-modes '(asm-mode)
    :server-id 'asm-lsp)))
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; (require 'syzlang-mode) 
;; syzlang mode is my yet unfinished and unpublished attempt to bring syzlang syntax highlighting to emacs
(require 'org-static-blog)

(setq org-static-blog-root-dir "~/org-blog/")

(setq org-static-blog-publish-title "forestfoxx's Org Static Blog")
(setq org-static-blog-publish-url (format "https://forestfoxx.github.io/"))
(setq org-static-blog-publish-directory (format "%s" org-static-blog-root-dir))
(setq org-static-blog-posts-directory (format "%sorg" org-static-blog-root-dir))
(setq org-static-blog-drafts-directory (format "%sdrafts" org-static-blog-root-dir))
(setq org-static-blog-page-header (with-temp-buffer
  (insert-file-contents (format "%sstatic/header.html" org-static-blog-root-dir))
  (buffer-string)))
(setq org-static-blog-page-preamble (with-temp-buffer
  (insert-file-contents (format "%sstatic/preamble.html" org-static-blog-root-dir))
  (buffer-string)))
(setq org-static-blog-page-postamble (with-temp-buffer
  (insert-file-contents (format "%sstatic/postamble.html" org-static-blog-root-dir))
  (buffer-string)))
(setq org-static-blog-enable-tags t)
(setq org-static-blog-use-preview t)
(setq org-static-blog-index-front-matter
      "<h1 class=title> Recent Posts </h1>")
