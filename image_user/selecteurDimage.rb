# encoding: UTF-8

# encoding: UTF-8

##
# Auteur MATHIAS DIDIER

require 'gtk2'



class SelecteurDimage < Gtk::Builder

	@tube
	
  def initialize(tubeEcriture)
    super()
    @tube = tubeEcriture
    self.add_from_file(__FILE__.sub(".rb",".glade"))
    
    #self['filechooserdialog1'].set_window_position Gtk::Window::POS_CENTER
    self['filechooserdialog1'].signal_connect('destroy') { @filechooserdialog1.destroy }
    self['filechooserdialog1'].show_all
    
    @filter = Gtk::FileFilter.new
    @filter.add_pattern("*.jpg")
    self['filechooserdialog1'].filter = @filter
    
    # Creation d'une variable d'instance par composant glade
    self.objects.each() { |p|
    	puts p
        instance_variable_set("@#{p.builder_name}".intern, self[p.builder_name])
     }

     self.connect_signals{ |handler| 
        puts handler
        method(handler)
      }
      
      
  end

	def charger_image()      		
      		image_file_name= @filechooserdialog1.filename
      		p image_file_name
      		begin
      			@image1.file=(image_file_name)
      			
      		rescue
      			puts "probleme chargement image #{image_file_name}"
      		end
		
      end
      
      def envoi()
      	@tube.puts @filechooserdialog1.filename
        @filechooserdialog1.destroy
      end

end

#Gtk.init
#selecteurDimage = SelecteurDimage.new()
#Gtk.main
