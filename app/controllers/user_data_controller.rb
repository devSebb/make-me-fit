class UserDataController < ApplicationController
  def index
    @user_data = UserDatum.all
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

    Rails.logger.debug "Step #{@step} data: #{@user_data.attributes.inspect}"

    if @user_data.valid?
      if @step < 3
        session[:user_data] = @user_data.attributes.except("id", "created_at", "updated_at", "user_id")
        redirect_to new_user_datum_path(step: @step + 1)
      else
        @user_data.user = current_user if user_signed_in?
        if @user_data.save
          session.delete(:user_data)
          redirect_to @user_data, notice: "User data was successfully created."
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
  end

  def update
    @user_data = UserDatum.find(params[:id])
    if @user_data.update(user_data_params)
      redirect_to @user_data, notice: "User data was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @user_data = UserDatum.find(params[:id])
    @user_data.destroy
    redirect_to user_data_index_path, notice: "User data was successfully destroyed."
  end

  def next_step
    @user_data = UserDatum.new(user_data_params)
    @step = params[:step].to_i
    @step += 1
    render turbo_stream: turbo_stream.replace("step#{@step - 1}", partial: "step#{@step}", locals: { user_data: @user_data })
  end

  def previous_step
    @user_data = UserDatum.new(user_data_params)
    @step = params[:step].to_i
    @step -= 1
    render turbo_stream: turbo_stream.replace("step#{@step + 1}", partial: "step#{@step}", locals: { user_data: @user_data })
  end

  private

  def user_data_params
    params.require(:user_datum).permit(:age, :gender, :current_weight, :activity_level, :workout_type, :fitness_goal, :food_preferences, :count_meals, :snacks)
  end
end
