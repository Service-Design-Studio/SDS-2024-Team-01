module Admin
    class CharitiesController < ApplicationController
      before_action :authenticate_user!
      before_action :set_charity, only: [:approve, :disable]
      before_action :check_admin, only: [:approve, :disable, :index]
  
      def index
        @active_charities = Charity.where(status: 'Active')
        @inactive_charities = Charity.where(status: 'Inactive')
      end
  
      def approve
        Charity.transaction do
          @charity.update!(status: 'Active')
          unique_code = generate_unique_code
          CharityCode.create!(charity: @charity, status: 'Approved', code: unique_code)
          CharityMailer.with(charity: @charity, code: unique_code).approval_email.deliver_later
        end
        redirect_to admin_charities_path(anchor: 'active-tab'), notice: 'Charity approved successfully and email sent.'
      rescue ActiveRecord::RecordInvalid
        redirect_to admin_charities_path(anchor: 'inactive-tab'), alert: 'There was an error approving the charity.'
      end
  
      def disable
        @charity.update(status: 'Inactive')
        redirect_to admin_charities_path(anchor: 'inactive-tab'), notice: 'Charity disabled successfully.'
      end
  
      private
  
      def set_charity
        @charity = Charity.find(params[:id])
      end
  
      def check_admin
        unless current_user.admin?
          redirect_to root_path, alert: 'You are not authorized to perform this action.'
        end
      end
  
      def generate_unique_code
        SecureRandom.hex(10)
      end
    end
  end
  