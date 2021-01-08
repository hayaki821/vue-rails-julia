class CreateJuliaService
    def initialize(julia_params, count=100, width=500, height=500) 
        @min_x = julia_params[:min_x]
        @max_x = julia_params[:max_x]
        @min_y = julia_params[:min_y]
        @max_y = julia_params[:max_y]
        @c_real = julia_params[:comp_const][:re] # Complex constant real
        @c_imag = julia_params[:comp_const][:im] # Complex constant imaginary
        @count = count # boundary condition
        @width = width # canvas width
        @height = height # canvas height
        @rgb = 255 # rgb max concentration 
        @image_data = [] # julia pixel data
    end

    def call
        @height.times do |y|
            @width.times do |x|
                z_real = ((@max_x - @min_x) / @width) * x + @min_x
                z_imag = ((@max_y - @min_y) / @height) * y + @min_y
    
                set_pixel_color(x, y, z_real, z_imag)
            end
        end
        return @image_data
    end
    
    def set_pixel_color(x, y, z_real, z_imag)
        # Calculation julia recurrence formula
        @count.times do |i|
             # if Divergence
            if z_real * z_real + z_imag * z_imag >= 4
                @image_data[(y * @width + x) * 4 + 0] = set_rgb(i,"R")
                @image_data[(y * @width + x) * 4 + 1] = set_rgb(i,"G")
                @image_data[(y * @width + x) * 4 + 2] = set_rgb(i,"B")
                @image_data[(y * @width + x) * 4 + 3] = @rgb
                return
            end
    
            # update
            real = z_real * z_real - z_imag * z_imag + @c_real
            imag = 2 * z_real * z_imag + @c_imag
            z_real = real
            z_imag = imag
        end
    
        # convergence
        @image_data[(y * @width + x) * 4 + 0] = 0
        @image_data[(y * @width + x) * 4 + 1] = 0
        @image_data[(y * @width + x) * 4 + 2] = 0
        @image_data[(y * @width + x) * 4 + 3] = @rgb 
      end
    
      # Calculation color
      def set_rgb(n, color)
        # percentage
        percent = n / @count.to_f
        # specific gravity
        w = 0.3
        # decide color pixels
        case color
        when "R" 
            return (percent ** w * @rgb).round
        when "G" 
            return 0
        when "B" 
            return ((1 - percent) ** w * @rgb).round
        else
            return 0
        end    
      end

end