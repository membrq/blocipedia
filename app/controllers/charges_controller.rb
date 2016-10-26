class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: 15_00
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 15_00,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    if charge.paid = true
      flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
      current_user.premium!
    else
      flash[:alert] = "Try again!"
    end

    redirect_to user_path(current_user)

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def destroy
    current_user.standard!
    current_user.wikis.each do |wiki|
      wiki.update(private: false)
    end 
    flash[:notice] = "You have successfully downgraded your account."
    redirect_to user_path(current_user)
  end

 end
