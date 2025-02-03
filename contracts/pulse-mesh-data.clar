;; PulseMesh Data Contract
;; Handles storage and retrieval of health metrics

;; Constants
(define-constant contract-owner tx-sender)
(define-constant err-unauthorized (err u100))
(define-constant err-invalid-data (err u101))

;; Data structures
(define-map user-health-data
  principal
  {
    steps: uint,
    heart-rate: uint,
    calories: uint,
    last-updated: uint
  }
)

;; Public functions
(define-public (record-health-metrics (steps uint) (heart-rate uint) (calories uint))
  (let ((user tx-sender)
        (timestamp (unwrap! (get-block-info? time (- block-height u1)) err-invalid-data)))
    (ok (map-set user-health-data
      user
      {
        steps: steps,
        heart-rate: heart-rate,
        calories: calories,
        last-updated: timestamp
      }
    ))
  )
)

;; Read only functions  
(define-read-only (get-user-metrics (user principal))
  (ok (map-get? user-health-data user))
)
