;; PulseMesh Rewards Contract
;; Handles reward distribution and achievements

;; Constants
(define-constant contract-owner tx-sender)

;; Define reward token
(define-fungible-token pulse-token)

;; Public functions
(define-public (mint-achievement-reward (user principal) (achievement-id uint))
  (let ((reward-amount u100))
    (if (is-eq tx-sender contract-owner)
      (ft-mint? pulse-token reward-amount user)
      err-unauthorized
    )
  )
)

(define-public (transfer-rewards (amount uint) (recipient principal))
  (let ((sender tx-sender))
    (ft-transfer? pulse-token amount sender recipient)
  )
)
