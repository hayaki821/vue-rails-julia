class Api::JuliasController < ApplicationController
    protect_from_forgery :except => [:create] # csrf

    require './app/services/create_julia_service'
    before_action :params_type_validate, only: [:create]
  # POST /julias/create
  def create
    # julia params
    count = 100 # boundary condition
    width = 500 # canvas width
    height = 500 # canvas height
    
    # create julia
    image_data = CreateJuliaService.new(julia_params, count, width, height).call # pixel data
 
    render json: {:image_data=>image_data}
  end

  private
  def julia_params
      params.require(:julia).permit(
          :min_x, :max_x, :min_y, :max_y, comp_const: [:re, :im]
      )
  end

  # validates
  def params_type_validate
    errors = []
    julia_params.each do |key, value|
        # because comp_const is hash
        if key == "comp_const"
            value.each do |c_key, c_value|
                check_number(c_key, c_value, errors)
            end
        else
            check_number(key, value, errors)
        end
    end
    if errors.length != 0 
        render json: { errors: errors }, status: 404
    end
  end

  # check type int
  def check_number(key, value, errors)
    if !value.is_a?(Numeric)
        errors.push({key=> "数値を入力してください"})
    end
  end


end
