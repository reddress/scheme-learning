(use-modules (ice-9 ftw))  ;; for scandir

(scandir ".")  ;; like ls
;;; (chdir "some-dir")

(getcwd)
