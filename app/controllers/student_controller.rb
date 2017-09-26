class StudentController < ApplicationController
# Login page for student
# Hackaround : Can we use direct variables here instead of using these class variables and all??
  def login
    if request.get?

      if session[:roll_no] && session[:password]
        @result = Student.where(roll_no: session[:roll_no] , password: session[:password])
        if !@result.empty?
         redirect_to(student_dashboard_path)
        end
      end

      @logincred = Student.new
      @error = 0
    end

    if request.post?

      @logincred = Student.new(login_params)
    # @spassword = @logincred.password
      @result = Student.where(roll_no: @logincred.roll_no, password: @logincred.password)
    # If roll number and password exist
      if !@result.empty?
        session[:roll_no] = @logincred.roll_no
        session[:password] = @logincred.password
        redirect_to(student_dashboard_path)
      else
        @error = 1
      end
      # @logintable = Login.all

    end
  end

  def logout
    @logincred = Student.new
    @error = 0
    session.clear
    render 'login'
  end
# Dashboard for student
  def dashboard
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)

    end
    @named = Student.where(roll_no: session[:roll_no]).pluck(:name)
  end

  def view_menu
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)
    end
    @menus = Menu.all
    @extrasmenu = Item.all
  end

  def view_bill
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)
    end
# Get the number of days in the month in which the student joined
    @joined_date = Student.where(roll_no: session[:roll_no]).pluck(:created_at)[0]
    @joined_month = @joined_date.strftime("%B")
    @joined_day = @joined_date.strftime("%d")
    @joined_month_days = @joined_date.end_of_month.day
# Including the day on which he joined
    @effective_days = @joined_month_days.to_i - @joined_day.to_i + 1

# Calculate the number of mess cut days, that is the number of days for which the mess cut were accepted
    @mess_cut_days = 0
    @messcut_from_to = MessCut.where(roll_no: session[:roll_no], status: "yes").order(:id).pluck(:from, :to)
    if !@messcut_from_to.empty?
      @messcut_from_to.each do |data|
        @mess_cut_days += data[1] - data[0] + 1
      end
    end

# No of days to charge for
    @chargeable_days = @effective_days - @mess_cut_days

# Calculate extra's cost for that student
    @purchased = Extra.where(roll_no: session[:roll_no]).group('item').count('item')
    @purchase_total_cost = 0
    if !@purchased.empty?
      @purchased.each do |key, value|
        @cost = Item.where(item_name: key).pluck(:price)[0]
        @purchase_total_cost += @cost * value
      end
    end
# Calculating the total bill
# Assuming base price = RS 80
    @total = @chargeable_days * 80 + @purchase_total_cost
  end
	def view_mess_cut
	    if !(session[:roll_no] || session[:password])
	      redirect_to(student_login_path)
	    end
	    if request.get?
	      @cuts = MessCut.where(roll_no: session[:roll_no])
	    end
	end

  def apply_mess_cut
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)
    end

    if request.get?
      @messcut = MessCut.new
      @name = Student.where(roll_no: session[:roll_no]).pluck(:name)
    end

    if request.post?
      @messcut = MessCut.new(messcut_params)
      if ((@messcut.roll_no) && (@messcut.name) && (@messcut.from) && (@messcut.to))
      if @messcut.save
        flash[:notice] = "Successfully submitted..."
        redirect_to(student_apply_mess_cut_path)
      end
    else
      flash[:notice] = "One` or more fields empty!!!"
    end

    end
  end

  def pay_bill
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)
    end
      @currentbill = Bill.where(roll_no: session[:roll_no])
      @totalbill = 0
      if !@currentbill.empty?
        @currentbill.each do |data|
          @totalbill += data.amount
        end
      else
        @totalbill = -1
      end
  end

  def purchase_history
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)
    end
# Replace this hardcoded value with the session variables rollnumber and name
    # @purchased = Extra.where(roll_no: 123).group('item').count('item')
    @purchased = Extra.where(roll_no: session[:roll_no])

    @purchased1 = Extra.where(roll_no: session[:roll_no]).group('item').count('item')
    @purchase_total_cost1 = 0
    if !@purchased1.empty?
      @purchased1.each do |key, value|
        @cost1 = Item.where(item_name: key).pluck(:price)[0]
        @purchase_total_cost1 += @cost1 * value
      end
    end

  end

  def change_password
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)
    end

    if request.get?
      @credentials = Student.new
      @savedornot = ""
    end

    if request.post?
      @savedornot = ""
      @credentials = Student.new(changepass_params)
      @querydb = Student.where(roll_no: session[:roll_no], password: @credentials.email)
      if !@querydb.empty?
        @savedornot = "Successfully Changed the password"
        @querydb[0].password = @credentials.password
        @querydb[0].save
      else
        @savedornot = "You entered wrong Old password"
      end
    end


  end

  def feedback
    if !(session[:roll_no] || session[:password])
      redirect_to(student_login_path)
    end

    if request.get?
      @feedback = Feedback.new
      @name1 = Student.where(roll_no: session[:roll_no]).pluck(:name)
    end

    if request.post?
      @feedback = Feedback.new(feedback_params)
      if @feedback.save
        flash[:notice] = "Successfully sent feedback!"
        redirect_to(student_feedback_path)
      end
    end
  end
end

private
  def feedback_params
    params.require(:feedback).permit(:name, :s_id, :feedback)
  end

  def login_params
    params.require(:student).permit(:roll_no, :password)
  end

  def messcut_params
    params.require(:mess_cut).permit(:roll_no, :name, :from, :to)
  end

  def changepass_params
    params.require(:student).permit(:email, :password)
  end
