class ManagerController < ApplicationController

  def login
    #skip_before_filter :verify_authenticity_token
    if session[:admin] && session[:password]
      @result = Adminn.where(admin: session[:admin] , password: session[:password])
      if !@result.empty?
       redirect_to(manager_dashboard_path)
      end
    end

    if request.get?
      @logincred = Adminn.new
      @error = 0

    end

    if request.post?

      @logincred = Adminn.new(adminn_params)
    # @spassword = @logincred.password
      @result = Adminn.where(admin: @logincred.admin, password: @logincred.password)
    # If roll number and password exist
      if !@result.empty?
        session[:admin] = @logincred.admin
        session[:password] = @logincred.password
        session[:v] = 1

        redirect_to(manager_dashboard_path)

      else
        @error = 1
      end
      # @logintable = Login.all

    end
  end


  def logout
    @logincred = Adminn.new
    @error = 0
    session.clear
    render 'login'
  end



  def add_student

    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    if request.get?
      @student = Student.new
    end
    if request.post?
      @student = Student.new(student_params)
      if @student.save
        flash[:notice] = "Successfully created..."
        redirect_to(manager_add_student_path)
      end
   end
  end


  def delete_student
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    if request.get?
      @student = Student.new
    end
    if request.post?
      @student = Student.find_by_roll_no(params[:student][:roll_no])
      @student.destroy
      flash[:notice] = "Successfully deleted '#{@student.name}'..."
      redirect_to(manager_delete_student_path)
    end
  end


  def view_menu
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    if request.get?
      @menus = Menu.all
    end
    if request.post?
      @menu = Menu.find(params[:id])
    end
  end


  def update_menu
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    @menu = Menu.find(params[:id])
    if request.patch?
      if  @menu.update_attributes(menu_params)
        flash[:notice] = "Successfully updated menu ... "
        redirect_to(manager_view_menu_path)
      end
    end
  end


  def add_mess_cut
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    if request.get?
      @cuts = MessCut.all
    end
    if request.post?
      #@cut = MessCut.find(params[:id])
    end

  end

  def update_mess_cut
  #  @cut = MessCut.find(params[:id])
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    @cut = MessCut.find(params[:id])
    if request.patch?
      if  @cut.update_attributes(mess_cut_params)
        flash[:notice] = "Successfully updated menu ... "
        redirect_to(manager_add_mess_cut_path)
      end
    end
  end

  def per_month_fee_detail
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end

    if request.get?
      @bills = Bill.where(:status => '0')
    end
    if request.post?
      #@menu = Menu.find(params[:id])
    end

  end



  def update_per_month_fee_detail
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    @bill = Bill.find(params[:id])
    if request.patch?
      if  @bill.update_attributes(fee_params)
        flash[:notice] = "Successfully updated menu ... "
        redirect_to(manager_per_month_fee_detail_path)
      end
    end
  end

  def extra_per_day
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    if request.get?
      @extra = Extra.new
    end
    if request.post?
      @extra = Extra.new(extra_params)
      if @extra.save
        flash[:notice] = "Successfully created..."
        redirect_to(manager_extra_per_day_path)
      end
   end
  end

  def backup_db
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end

    #system("backup perform -t ~/db_backup")
    #fork { exec 'backup perform -t db_backup' }

  end

  def view_stock
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    if request.get?
      @stocks = Stock.all
    end
    if request.post?
        @stock = Stock.find(params[:id])
    end

  end

  def update_stock
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
    @stock = Stock.find(params[:id])
    if request.patch?
      if  @stock.update_attributes(stock_params)
        flash[:notice] = "Successfully updated stock ... "
        redirect_to(manager_view_stock_path)
      end
    end
  end

  def monthly_profit_analysis
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
  end

  def view_feedback
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end

    @feedbacks = Feedback.all


  end

  def update_bill
    if ((session[:v] != 1) || !(session[:admin] || session[:password]))
      redirect_to(manager_login_path)
    end
  
    @students = Student.all
    @students.each do |f|
        @joined_date = Student.where(roll_no: f.roll_no).pluck(:created_at)[0]
        @joined_month = @joined_date.strftime("%B")
        @joined_day = @joined_date.strftime("%d")
        @joined_month_days = @joined_date.end_of_month.day
      # Including the day on which he joined
        @effective_days = @joined_month_days.to_i - @joined_day.to_i + 1
  
      # Calculate the number of mess cut days, that is the number of days for which the mess cut were accepted
        @mess_cut_days = 0
        @messcut_from_to = MessCut.where(roll_no: f.roll_no, status: "yes").order(:id).pluck(:from, :to)
        @messcut_from_to.each do |data|
          @mess_cut_days += data[1] - data[0] + 1
        end
  
      # No of days to charge for
        @chargeable_days = @effective_days - @mess_cut_days
  
      # Calculate extra's cost for that student
        @purchased = Extra.where(roll_no: f.roll_no).group('item').count('item')
        @purchase_total_cost = 0
        @purchased.each do |key, value|
          @cost = Item.where(item_name: key).pluck(:price)[0]
          @purchase_total_cost += @cost * value
        end
      # Calculating the total bill
      # Assuming base price = RS 80
        @total = @chargeable_days * 80 + @purchase_total_cost
        @bill = Bill.create(:roll_no => f.roll_no, :amount => @total, :status => '0', :month => Date::MONTHNAMES.index(@joined_month))
    end
  
  
    redirect_to(manager_login_path)
  
  end

  # def change_password
  #   if !(session[:roll_no] || session[:password])
  #     redirect_to(student_login_path)
  #   end
  #
  #   if request.get?
  #     @credentials = Adminn.new
  #     @savedornot = ""
  #   end
  #
  #   if request.post?
  #     @savedornot = ""
  #     @credentials = Adminn.new(adminn_params)
  #     @querydb = Adminn.where(roll_no: session[:roll_no], password: @credentials.admin)
  #     if !@querydb.empty?
  #       @savedornot = "Successfully Changed the password"
  #       @querydb[0].password = @credentials.password
  #       @querydb[0].save
  #     else
  #       @savedornot = "You entered wrong Old password"
  #     end
  #   end
  #
  #
  # end




end


private
  def student_params

    params.require(:student).permit(:name, :phone, :roll_no, :email, :password)

  end

  def menu_params
    params.require(:menu).permit(:day, :meal1, :meal2, :meal3)
  end

  def stock_params
    params.require(:stock).permit(:stock_id, :stock_name, :quantity, :cost_per_unit)
  end

  def adminn_params
    params.require(:adminn).permit(:admin, :password)
  end

  def extra_params
    params.require(:extra).permit(:roll_no, :item, :date)
  end

  def fee_params
    params.require(:bill).permit(:status)
  end

  def mess_cut_params
    params.require(:mess_cut).permit(:roll_no, :name, :from, :to, :status)
  end

  # def changepass_params
  #   params.require(:adminn).permit(:admin, :password)
  # end
