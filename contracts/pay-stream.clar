;; ------------------------------------------------
;; Contract: pay-stream
;; Trustless Recurring Payment Contract
;; ------------------------------------------------

(define-constant ERR_NOT_EMPLOYER (err u100))
(define-constant ERR_NO_STREAM (err u101))
(define-constant ERR_ZERO_AMOUNT (err u102))
(define-constant ERR_NOT_ENOUGH_FUNDS (err u103))

;; Data structure for salary stream
(define-map streams
  { employee: principal }
  { employer: principal, amount-per-block: uint, last-claimed: uint })

;; ------------------------------
;; Public Functions
;; ------------------------------

;; Create a new payment stream
(define-public (create-stream (employee principal) (amount-per-block uint))
  (begin
    (if (is-eq amount-per-block u0) ERR_ZERO_AMOUNT
      (begin
        (map-set streams { employee: employee }
          { employer: tx-sender, amount-per-block: amount-per-block, last-claimed: stacks-block-height })
        (ok true)))))

;; Claim payment (employee withdraws accrued STX)
(define-public (claim)
  (match (map-get? streams { employee: tx-sender })
    stream-data
      (let (
            (employer (get employer stream-data))
            (rate (get amount-per-block stream-data))
            (last (get last-claimed stream-data))
            (blocks-elapsed (- stacks-block-height last))
            (payment (* rate blocks-elapsed))
           )
        (if (> payment u0)
          (begin
            ;; Update last claimed block
            (map-set streams { employee: tx-sender }
              { employer: employer, amount-per-block: rate, last-claimed: stacks-block-height })
            ;; Transfer STX from employer to employee
            (stx-transfer? payment employer tx-sender))
          ERR_NOT_ENOUGH_FUNDS))
    ERR_NO_STREAM))

;; Cancel a payment stream (employer only)
(define-public (cancel-stream (employee principal))
  (match (map-get? streams { employee: employee })
    stream-data
      (if (is-eq (get employer stream-data) tx-sender)
        (begin
          (map-delete streams { employee: employee })
          (ok true))
        ERR_NOT_EMPLOYER)
    ERR_NO_STREAM))

;; ------------------------------
;; Read-Only Functions
;; ------------------------------

;; Check active stream details
(define-read-only (get-stream (employee principal))
  (map-get? streams { employee: employee }))
