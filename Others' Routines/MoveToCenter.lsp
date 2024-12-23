(defun c:MoveToCenter (/ line1 line2 line3 midpt1 midpt2 newpt)
  (defun get-midpoint (pts)
    (mapcar '(lambda (a b) (/ (+ a b) 2.0)) (car pts) (cadr pts))
  )
  (setq line1 (car (entsel "\nSelect the first line: ")))
  (setq line2 (car (entsel "\nSelect the second line: ")))
  (setq line3 (car (entsel "\nSelect the line to move: ")))
  (setq pts1 (if (= (cdr (assoc 0 (entget line1))) "LWPOLYLINE")
                 (list (vlax-curve-getPointAtParam line1 0) (vlax-curve-getPointAtParam line1 (vlax-curve-getEndParam line1)))
                 (list (cdr (assoc 10 (entget line1))) (cdr (assoc 11 (entget line1)))))
  )
  (setq pts2 (if (= (cdr (assoc 0 (entget line2))) "LWPOLYLINE")
                 (list (vlax-curve-getPointAtParam line2 0) (vlax-curve-getPointAtParam line2 (vlax-curve-getEndParam line2)))
                 (list (cdr (assoc 10 (entget line2))) (cdr (assoc 11 (entget line2)))))
  )
  (setq midpt1 (get-midpoint pts1))
  (setq midpt2 (get-midpoint pts2))
  (setq newpt (mapcar '(lambda (a b) (/ (+ a b) 2.0)) midpt1 midpt2))
  (command "_.move" line3 "" "_non" (cdr (assoc 10 (entget line3))) "_non" newpt)
  (princ)
)
