class ExpensesController < ApplicationController
  before_action :authenticate_user!

    def index
    	@current_user = current_user
      # @expenses = Expense.order("date DESC")
      @expenses = @current_user.expenses.order("date DESC")

      if params[:concept].present? && params[:category_id].present?
        @expenses = @expenses.where("concept LIKE :q", q: "%#{params[:concept]}%")
        @expenses = @expenses.where("category_id = ?", params[:category_id])
      elsif params[:category_id].present?
        @expenses = @expenses.where("category_id = ?", params[:category_id])
      elsif params[:concept].present?
        @expenses = @expenses.where("concept LIKE :q", q: "%#{params[:concept]}%")
      end
      respond_to do |format|
        format.html
        format.js
        format.json { render json: @responses }
      end

  		UserMailer.welcome(@current_user, @expenses).deliver_now
  		# UserMailer.welcome(@current_user).deliver_later
  		# se hace con background job

  		# flash[:success] = "Has iniciado sesión"
    end

    # def new
    #   @person = Person.new
    #   2.times do
    #     @person.addresses.build
    #   end
    # end

    # def show
    #   @person = Person.find(params[:id])
    # end

    # def edit
    # end

    # def update
    # end

    # def create
    #   @person = Person.create!(person_params)
    #   respond_to do |format|
    #     format.html { redirect_to people_path}
    #     format.json { render json: person}
    #     format.js
    #   end
    # end

    # private

    # def person_params
    #   params.require(:person).permit(:name, :email, addresses_attributes: [:city, :street])
    # end


  end
