class ExpensesController < ApplicationController
  def index
    @expenses = Expense.order("date DESC")

    if params[:concept].present? && params[:category_id].present?
      @expenses = @expenses.where("concept LIKE :q", q: "%#{params[:concept]}%")
      @expenses = @expenses.where("category_id = ?", params[:category_id])
    elsif params[:category_id].present?
      @expenses = @expenses.where("category_id = ?", params[:category_id])
    elsif params[:concept].present?
      @expenses = @expenses.where("concept LIKE :q", q: "%#{params[:concept]}%")
    end
  end
end

# def index
#     @expenses = Expense.order("date DESC")
#
#     if params[:concept].present? && params[:category_id].present?
#       @expenses = @expenses.where("concept LIKE :q", q: "%#{params[:concept]}%")
#       @expenses = @expenses.where("category_id = ?", params[:category_id])
#     elsif params[:category_id].present?
#       @expenses = @expenses.where("category_id = ?", params[:category_id])
#     elsif params[:concept].present?
#       @expenses = @expenses.where("concept LIKE :q", q: "%#{params[:concept]}%")
#     end
# end
