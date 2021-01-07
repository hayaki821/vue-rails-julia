class Api::JuliasController < ApplicationController
    before_action :params_type_validate, only: [:create]
  # POST /tasks
  def create
    # create model
    #render plain: julia_params.inspect
    min_x = julia_params[:min_x]
    max_x = julia_params[:max_x]
    min_y = julia_params[:min_y]
    max_y = julia_params[:max_y]
    c_real = julia_params[:comp_const][:re] # Complex constant real
    c_imag = julia_params[:comp_const][:im] # Complex constant imaginary

    count = 100 # boundary condition
    width = 600
    height = 600
    image_data = [] # pixel data

    draw_julia_create(image_data,max_x, min_x, max_y, min_y, width, height, count, c_real, c_imag)
 
    render json: {:image_data=>image_data}
    
    # if employee.save
    #     render json: employee, status: :created
    #   else
    #     render json: { errors: employee.errors.full_messages }, status: :unprocessable_entity
    #   endder json: @task.errors, status: :unprocessable_entity
    # end
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
                check_int(c_key, c_value, errors)
            end
        else
            check_int(key, value, errors)
        end
    end
    if errors.length != 0 
        render json: { errors: [errors] }, status: 404
    end
  end

  # check type int
  def check_int(key, value, errors)
    if !value.is_a?(Float)
        errors.push({key=> "数値を入力してください"})
    end
  end

  def draw_julia_create(image_data,max_x, min_x, max_y, min_y, width, height, count, c_real, c_imag)
    height.times do |y|
        width.times do |x|
            z_real = ((max_x - min_x) / width) * x + min_x
            z_imag = ((max_y - min_y) / height) * y + min_y

            set_pixel_color(image_data, width, height, x, y, z_real,z_imag, count, c_real, c_imag)
        end
    end
  end

  def set_pixel_color(image_data, width, height, x, y, z_real,z_imag, count,c_real, c_imag)
    # Calculation julia recurrence formula
    count.times do |i|
         # if Divergence
        if z_real * z_real + z_imag * z_imag >= 4
            image_data[(y * width + x) * 4 + 0] = set_rgb(i,"R", count)
            image_data[(y * width + x) * 4 + 1] = set_rgb(i,"G", count)
            image_data[(y * width + x) * 4 + 2] = set_rgb(i,"B", count)
            image_data[(y * width + x) * 4 + 3] = 255
            return
        end

        # update
        real = z_real * z_real - z_imag * z_imag + c_real
        imag = 2 * z_real * z_imag + c_imag
        z_real = real
        z_imag = imag
    end

    # convergence
    image_data[(y * width + x) * 4 + 0] = 0
    image_data[(y * width + x) * 4 + 1] = 0
    image_data[(y * width + x) * 4 + 2] = 0
    image_data[(y * width + x) * 4 + 3] = 255
  end

  # Calculation color
  def set_rgb(n, color, count)
    percent = n / count
    case color
    when "R" 
        return percent ** 0.3 * 255
    when "G" 
        return 0
    when "B" 
        return (1 - percent) ** 0.3 * 255
    else
        return 0
    end    
  end
end
