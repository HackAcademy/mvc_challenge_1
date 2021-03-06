class EmployeesController < ApplicationController
  before_action :authenticate_company!
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :set_department, only: [:index, :create]

  # GET /employees
  # GET /employees.json
  def index
    @employee = Employee.find_or_initialize_by(id: params[:id])
  end

  def search
    @employees = Employee.search_by_company(params[:keywords], current_company)
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = @department.employees.build(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to department_employees_path, notice: 'El empleado fue creado exitosamente' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to department_employees_path(params[:department_id]), notice: 'El empleado fue actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to department_employees_path, notice: 'El empleado fue eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def set_department
      @department = Department.find(params[:department_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:first_name, :middle_name, :last_name, :identity, :account_number, :account_type, :bank, :phone_home, :phone_mobile, :phone_emergency, :email_personal)
    end
end
