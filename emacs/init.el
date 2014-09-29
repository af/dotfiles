;; Package management
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

;;; from purcell/.emacs.d
(defun require-package (package &optional min-version no-refresh)
    "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
    (if (package-installed-p package min-version)
        t
        (if (or (assoc package package-archive-contents) no-refresh)
            (package-install package)
            (progn
                  (package-refresh-contents)
                  (require-package package min-version t)))))

(package-initialize)

(require-package 'better-defaults)

(require-package 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;This is your old M-x.

;; js2-mode for javascript
;; More tips and tricks: https://github.com/cjohansen/.emacs.d/blob/master/setup-js2-mode.el
(require-package 'js2-mode)
(setq-default js2-strict-missing-semi-warning nil)
(setq-default js2-global-externs '("require" "process" "$" "JSON"))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(require-package 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(require-package 'helm)
(global-set-key (kbd "C-c h") 'helm-mini)

(require-package 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Evil mode configuration
(require-package 'evil)
(setq evil-search-module 'evil-search
      evil-want-C-u-scroll t
      evil-want-C-w-in-emacs-state t)
(require 'evil)
(evil-mode t)

;; Color themes
;; switching: "M-x load-theme RET molokai"
(require-package 'color-theme-approximate)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'molokai t)
(color-theme-approximate-on)

;; Misc settings
(global-linum-mode t)         ;; Show line numbers globally
(setq make-backup-files nil)
(setq auto-save-default nil)  ;; TODO: "real" autosave
