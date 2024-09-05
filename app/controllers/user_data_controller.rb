class UserDataController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :edit, :update ]

  def index
    @user_data = current_user.user_datum
    if @user_data.nil?
      flash[:notice] = "You haven't created your user data yet."
      redirect_to new_user_datum_path
    end
  end

  def show
    @user_data = UserDatum.find(params[:id])
    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.replace("user_data_form", partial: "show", locals: { user_data: @user_data }) }
    end
  end

  def new
    @user_data = UserDatum.new(session[:user_data] || {})
    @step = params[:step].present? ? params[:step].to_i : 1
    @step = 1 if @step < 1 || @step > 3
  end

  def create
    @step = params[:step].to_i
    @user_data = UserDatum.new(session[:user_data] || {})
    @user_data.assign_attributes(user_data_params)
    @user_data.step = @step

    if @user_data.valid?
      if @step < 3
        session[:user_data] = @user_data.attributes.except("id", "created_at", "updated_at", "user_id")
        redirect_to new_user_datum_path(step: @step + 1)
      else
        @user_data.user = current_user
        if @user_data.save
          session.delete(:user_data)
          redirect_to user_data_path(@user_data), notice: "User data was successfully created."
        else
          render :new, status: :unprocessable_entity
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user_data = UserDatum.find(params[:id])
    render :index
  end

  def update
    @user_data = UserDatum.find(params[:id])
    if @user_data.update(user_data_params)
      redirect_to user_data_path(@user_data), notice: "User data was successfully updated."
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @user_data = UserDatum.find(params[:id])
    @user_data.destroy
    redirect_to user_data_index_path, notice: "User data was successfully destroyed."
  end

  def next_step
    @step = params[:step].to_i
    @user_data = UserDatum.new(session[:user_data] || {})
    @user_data.assign_attributes(user_data_params)
    @user_data.step = @step

    if @user_data.valid?
      session[:user_data] = @user_data.attributes.except("id", "created_at", "updated_at", "user_id")
      redirect_to new_user_datum_path(step: @step + 1)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def previous_step
    @step = params[:step].to_i
    @user_data = UserDatum.new(session[:user_data] || {})
    @user_data.assign_attributes(user_data_params)
    @step -= 1
    render turbo_stream: turbo_stream.replace("user_data_form", partial: "form", locals: { user_data: @user_data, step: @step })
  end

  private

  def user_data_params
    params.require(:user_datum).permit(:age, :gender, :current_weight, :activity_level, :workout_type, :fitness_goal, :food_preferences, :count_meals, :snacks)
  end
end
