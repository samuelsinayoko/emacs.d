;; Configuration for the English and Welsh Bank Holidays.  Accounts
;; for weekends.  Dates sourced from the UK Department of Trade and
;; Industry (http://www.dti.gov.uk/er/bankhol.html).
;;
;; Suitable for a .emacs file.  Enable with a line like:
;;
;; (setq other-holidays (append english-and-welsh-bank-holidays
;;                              other-holidays))
;;
;; or, to override US holidays, like:
;;
;; (setq general-holidays english-and-welsh-bank-holidays)

(defun abs-easter (displayed-year)
  "Return the absolute date of Easter Sunday in DISPLAYED-YEAR.
Taken directly from `holiday-easter-etc' in holidays.el.  Perhaps
it would be better to have this function there."
  (let* ((century (1+ (/ displayed-year 100)))
         (shifted-epact	;; Age of moon for April 5...
          (% (+ 14 (* 11 (% displayed-year 19))	;;     ...by Nicaean rule
                (- ;; ...corrected for the Gregorian century rule
                 (/ (* 3 century) 4))
                (/ ;; ...corrected for Metonic cycle inaccuracy.
                 (+ 5 (* 8 century)) 25)
                (* 30 century))	;;              Keeps value positive.
             30))
         (adjusted-epact ;;  Adjust for 29.5 day month.
          (if (or (= shifted-epact 0)
                  (and (= shifted-epact 1) (< 10 (% displayed-year 19))))
              (1+ shifted-epact)
            shifted-epact))
         (paschal-moon ;; Day after the full moon on or after March 21.
          (- (calendar-absolute-from-gregorian (list 4 19 displayed-year))
             adjusted-epact)))
    (calendar-dayname-on-or-before 0 (+ paschal-moon 7))))

(eval-when-compile
  ;; free vars - should these be defined by calendar?
  (defvar year)
  (defvar date))

(defun ewbh-xmas (day-in-dec)
  "Return the English and Welsh Bank Holiday for DAY-IN-DECember.
Expects DAY-IN-DEC to be either 25 or 26.  Accounts for weekends."
  (let* ((date `(12 ,day-in-dec ,year))
         (day (calendar-day-name date)))
    (cond
     ((equal day "Saturday")
      (calendar-gregorian-from-absolute
       (calendar-dayname-on-or-before
        1                               ; Monday
        (+ 7 (calendar-absolute-from-gregorian date)))))
     ;; Boxing Day on Sunday means Christmas was on Saturday
     ((equal day "Sunday")
      (calendar-gregorian-from-absolute
       (calendar-dayname-on-or-before
        2                               ; Tuesday
        (+ 7 (calendar-absolute-from-gregorian date)))))
     (t date))))

(defun ewbh-weekday (date)
  "Return the Monday following DATE if DATE falls on a weekend, else DATE.
DATE must be a (month day year) list."
  (let* ((abs-date (calendar-absolute-from-gregorian date))
         (day (calendar-day-name date)))
    (if (or (equal day "Saturday")
            (equal day "Sunday"))
        (calendar-gregorian-from-absolute
         (calendar-dayname-on-or-before
          1                             ; Monday
          (+ 7 abs-date)))
      date)))

(defvar english-and-welsh-bank-holidays
  '((holiday-sexp '(ewbh-weekday `(1 1 ,year))
                  "New Year's Day Bank Holiday")
    (holiday-sexp '(calendar-gregorian-from-absolute
                    (- (abs-easter year) 2))
                  "Good Friday Bank Holiday")
    (holiday-sexp '(calendar-gregorian-from-absolute
                    (1+ (abs-easter year)))
                  "Easter Monday Bank Holiday")
    (holiday-float 5 1 1 "Early May Bank Holiday")
    (holiday-float 5 1 -1 "Spring Bank Holiday")
    (holiday-float 8 1 -1 "Summer Bank Holiday")
    (holiday-sexp '(ewbh-xmas 25)
                  "Christmas Day Bank Holiday")
    (holiday-sexp '(ewbh-xmas 26)
                  "Boxing Day Bank Holiday"))
  "*Bank holidays for England and Wales, according to the UK Department
of Trade and Industry (http://www.dti.gov.uk/er/bankhol.html).")

(setq holiday-local-holidays english-and-welsh-bank-holidays)

(provide 'english-and-welsh-bank-holidays)
