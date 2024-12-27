enum EventRequestState {
  // Pending: Request sent, awaiting response from admin
  pending,
  // Accepted: Request accepted by the admin
  accepted,
  // Rejected: Request declined by the admin
  rejected,
  // Canceled: Request canceled by the TeamLeader
  canceled;
}
