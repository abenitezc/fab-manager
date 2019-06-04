# frozen_string_literal: true

# Provides helper methods for Reservation actions
class Reservations::Reserve
  attr_accessor :user_id, :operator_id

  def initialize(user_id, operator_id)
    @user_id = user_id
    @operator_id = operator_id
  end

  def pay_and_save(reservation, payment_method, coupon)
    reservation.statistic_profile_id = User.find(user_id).statistic_profile.id
    if payment_method == :local
      reservation.save_with_local_payment(operator_id, coupon)
    elsif payment_method == :stripe
      reservation.save_with_payment(operator_id, coupon)
    end
  end
end
