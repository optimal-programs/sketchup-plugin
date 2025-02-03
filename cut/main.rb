#Sketchup Plugin for exporting sizes to an XML file supported by Cutting Optimization pro and Simple Cutting Software X.
#author: SC Optimal Programs SRL
#license: MIT
#disclaimer: this program is offered for free ... with no guarantees or responsibilities. Use it on your own risk !

#email: contact@optimalprograms.com
#web: https://www.optimalprograms.com

#version 1.7.3
#date 2025.01.06

#help:

#fore more info please read the help file from here (in English):

#https://www.optimalprograms.com/help/cutting_optimization_pro_en/files/exporting_google_sketchup_models.htm

#XML format is described here:

#https://www.optimalprograms.com/help/cutting_optimization_pro_en/files/format_of_cutting_optimization_pro_files.htm


require 'sketchup.rb'

#Sketchup.send_action "showRubyPanel:"

# encoding: UTF-8

module OptimalPrograms
  module CutProExporter

	$count_total_pieces = 0
    

	$lang_path="c:\\temp\\cut_sketchup_lang.txt"

	def self.get_lang
		local_lang = "English"

		if File.exist?($lang_path)
			#open the file and read the content
			fileObj = File.new($lang_path, "r")
			local_lang = fileObj.gets
			fileObj.close
		else
			# check if the path exists
			if !File.exist?("c:\\temp")
			# create dir
			Dir.mkdir("c:\\temp")
			end
		end
		return local_lang
	end

	def self.set_lang_strings(lang)
		case lang
		when "Romana"
			$sLabel = "Eticheta"	
			$sLayerName = "Numele stratului"	
			$sEntityName = "Denumirea entitatii"
			$sOptions = "Optiuni"	
			$sDataWrittenTo = "Datele au fost scrise în fisier:"
			$sFirstlyYouMustSaveTheModel = "In primul rand trebuie sa salvati modelul!"
			$sNoFileHasBeenGenerated = "Fisierul nu a fost generat."	
			$sIgnoreSizesLessThan = "Ignora dimensiuni mai mici decât"	
			$sUnableToWriteToFile = "In imposibilitatea de a scrie la date disc!"	
			$sYouMustSelectAnObject = "Trebuie să selectati un obiect!"		
		when "Bulgarian"
			$sLabel = 	"етикет"
			$sLayerName = 	"на слой"
			$sEntityName = 	"Заместващата"
			$sOptions = 	"Опции"
			$sDataWrittenTo = 	"Данните са записани във файл:"
			$sFirstlyYouMustSaveTheModel = 	"На първо място трябва да спаси модел!"
			$sNoFileHasBeenGenerated = 	"Файлът не е получен."
			$sIgnoreSizesLessThan = 	"Игнорирай размери по-малки от"
			$sUnableToWriteToFile = 	"Не може да се пише до данни на диска!"
			$sYouMustSelectAnObject = 	"Трябва да изберете обект!"
		when "Spanish"
			$sLabel = 	"etiqueta"
			$sLayerName = 	"nombre de capa"
			$sEntityName = 	"nombre de la entidad"
			$sOptions = 	"Opciones"
			$sDataWrittenTo = 	"Los datos se han escrito a presentar:"
			$sFirstlyYouMustSaveTheModel = 	"En primer lugar tienes que salvar el modelo!"
			$sNoFileHasBeenGenerated = 	"El archivo no se ha generado."
			$sIgnoreSizesLessThan = 	"Omitir los tamaños más pequeños que"
			$sUnableToWriteToFile = 	"No se puede escribir los datos en un disco!"
			$sYouMustSelectAnObject = 	"Usted debe seleccionar un objeto!"

		when "Portuguese"
			$sLabel = 	"etiqueta"
			$sLayerName = 	"nome da camada"
			$sEntityName = 	"nome da entidade"
			$sOptions = 	"opções"
			$sDataWrittenTo = 	"Os dados foram gravados no arquivo:"
			$sFirstlyYouMustSaveTheModel = 	"Em primeiro lugar você deve salvar o modelo!"
			$sNoFileHasBeenGenerated = 	"O arquivo não foi gerado."
			$sIgnoreSizesLessThan = 	"Ignorar tamanhos menores do que"
			$sUnableToWriteToFile = 	"Não foi possível gravar os dados para o disco!"
			$sYouMustSelectAnObject = 	"Você deve selecionar um objeto!"
			
		when "Italian"
			$sLabel = 	"etichetta"
			$sLayerName = 	"nome del layer"
			$sEntityName = 	"nome dell'entità"
			$sOptions = 	"opzioni"
			$sDataWrittenTo = 	"I dati sono stati scritti su file:"
			$sFirstlyYouMustSaveTheModel = 	"In primo luogo è necessario salvare il modello!"
			$sNoFileHasBeenGenerated = 	"Non è stato generato il file."
			$sIgnoreSizesLessThan = 	"Ignora le dimensioni più piccole"
			$sUnableToWriteToFile = 	"Impossibile scrivere i dati su disco!"
			$sYouMustSelectAnObject = 	"È necessario selezionare un oggetto!"
		when "French"
			$sLabel = 	"étiquette"
			$sLayerName = 	"Nom du calque"
			$sEntityName = 	"Nom de l'entité"
			$sOptions = 	"options d'"
			$sDataWrittenTo = 	"Les données ont été écrites dans le fichier:"
			$sFirstlyYouMustSaveTheModel = 	"Tout d'abord, vous devez enregistrer le modèle!"
			$sNoFileHasBeenGenerated = 	"Le fichier n'a pas été généré."
			$sIgnoreSizesLessThan = 	"Ignorer les tailles plus petites que"
			$sUnableToWriteToFile = 	"Impossible d'écrire les données sur le disque!"
			$sYouMustSelectAnObject = 	"Vous devez sélectionner un objet!"
	when "German"
			$sLabel = 	"Label"
			$sLayerName = 	"Layername"
			$sEntityName = 	"Entity Namen"
			$sOptions = 	"Optionen"
			$sDataWrittenTo = 	"Daten wurden in eine Datei geschrieben:"
			$sFirstlyYouMustSaveTheModel = 	"Zunächst müssen Sie das Modell speichern!"
			$sNoFileHasBeenGenerated = 	"Die Datei wurde nicht erzeugt."
			$sIgnoreSizesLessThan = 	"Ignorieren Größen kleiner als"
			$sUnableToWriteToFile = 	"Kann auf die Daten auf Disk zu schreiben!"
			$sYouMustSelectAnObject = 	"Sie müssen ein Objekt auswählen!"

		else
			$sLabel = "Label"
			$sLayerName = "Layer name"
			$sEntityName = "Entity name"
			$sOptions = "Options"
			$sDataWrittenTo = "Data have been written to file:"
			$sFirstlyYouMustSaveTheModel = "First you must save the model !"
			$sNoFileHasBeenGenerated = "The file has not been generated."
			$sIgnoreSizesLessThan = "Ignore sizes smaller than"
			$sUnableToWriteToFile = "Unable to write to the data to disc!"
			$sYouMustSelectAnObject = "You must select an object!"
		end
	end

	def self.isSimpleEntity(entity)
	  if ((entity.typename == "ComponentInstance") || (entity.typename == "Group"))
		return false
	  else
		return true
	  end
	end

	def self.recursive_count(entity, write_data, file, use_layer_name, ignore_less_than_size)
	  if ((entity.typename == "Face") || (entity.typename == "Edge")) #definitively this is not a group or component

	  else #number of entities > 0, now count how many simple entites are (edges, faces) and how many complex are
		simple = 0
		complex = 0
		if (entity.typename == "Group")
		  for i in 0..entity.entities.count - 1
			if (isSimpleEntity(entity.entities[i]))
			  simple = simple + 1
			else
			  complex = complex + 1
			  recursive_count(entity.entities[i], write_data, file, use_layer_name, ignore_less_than_size)
			end 
		  end
		else
		  if (entity.typename == "ComponentInstance") 
			for i in 0..entity.definition.entities.count - 1
			  if (isSimpleEntity(entity.definition.entities[i]))
				simple = simple + 1
			  else
				complex = complex + 1
				recursive_count(entity.definition.entities[i], write_data, file, use_layer_name, ignore_less_than_size)
			  end 
			end
		  end
		end
		
		if ((simple > 0) && (complex == 0))
		  if (entity.visible?)
			$count_total_pieces = $count_total_pieces + 1
			if (write_data)
			  write_piece_to_file(entity, file, use_layer_name, ignore_less_than_size)
			end #if
		  end #if
		end #if
	  end #if
	end #def

	def self.write_piece_to_file(entity, file, use_layer_name, ignore_less_than_size)

		if ((entity.typename == "ComponentInstance") || (entity.typename == "Group"))
		
		  width = entity.bounds.width
		  depth = entity.bounds.depth
		  height = entity.bounds.height

		  #take the 2 largest value

		  if (width > depth)
			value1 = width
			value2 = depth
		  else
			value1 = depth
			value2 = width
		  end 

		  if (value1 < height)
			value2 = value1
			value1 = height
		  else
			if (value2 < height)
			  value2 = height
			end
		  end
		  
		  #puts value1.to_l, value2.to_l, ignore_less_than_size.to_l
		  if (value1.to_l >= ignore_less_than_size) && (value2.to_l >= ignore_less_than_size)

			file.puts("<row>")
			  sir = value1.to_s;
			  sir = sir.gsub("~","")  # remove the approx sign
			  sir = sir.gsub(",",".")  # replace , with .
			  
			  file.puts("<length>" + sir + "</length>")

			  sir = value2.to_s;
			  sir = sir.gsub("~","")  # remove the approx sign
			  sir = sir.gsub(",",".")  # replace , with .
			  file.puts("<width>" + sir + "</width>")
			  
			  file.puts("<quantity>1</quantity>")
			  

			  if (entity.material == nil)
				file.puts("<material></material>")
			  else
				file.puts("<material>" + entity.material.display_name + "</material>")
			  end


			  file.puts("<allow_rotation>1</allow_rotation>") # rotation allowed

			  if ((entity.layer == nil) || (!use_layer_name))
				file.puts("<label>" + entity.name + "</label>") # label; change this as you want
			  else
				if (entity.name == "")
				  file.puts("<label>" + entity.layer.name + "</label>") # label; change this as you want
				else
				  file.puts("<label>" + entity.name + "+" + entity.layer.name + "</label>") # label; change this as you want
				end
			  end
				file.puts("</row>")
			end #endif value1 >= ignore_less_than_value && value2 >= ignore_less_than_value
		end #endif if ((entity.typename == "ComponentInstance") || (entity.typename == "Group"))

	end #def


	def self.compute_entities_and_save_results
	  model = Sketchup.active_model
	  selection = model.selection
	  
	  if selection.count == 0
		UI.messagebox("You must select an object!")
		return nil
	  end

	#  UI.messagebox selection.count

	  mname = model.title
	  model_path = model.path
	  
	  if model_path == ""
		UI.beep
		UI.messagebox($sFirstlyYouMustSaveTheModel + "\n" + $sNoFileHasBeenGenerated)
		return nil
	  end

	  om = Sketchup.active_model.options 
	  uo = om["UnitsOptions"] 

	  saved_SuppressUnitsDisplay = uo["SuppressUnitsDisplay"] #supress units display
	  uo["SuppressUnitsDisplay"] = true 

	  initial_lang = get_lang
	  set_lang_strings(initial_lang)
	  
	  prompts = ["Language", $sLabel, $sIgnoreSizesLessThan]
	  defaults = [initial_lang, $sEntityName + "+" + $sLayerName, "0"]
	  list = ["English|Romana|Portuguese|Spanish|Italian|French|German|Bulgarian", $sEntityName + "+" + $sLayerName + "|" + $sEntityName, ""]
	  input = UI.inputbox prompts, defaults, list, $sOptions
	  
	  if ((input == nil) || (input == false))
		return nil
	  end	
	  # I have to save the language

	  if initial_lang != input[0]
		  aFile = File.new($lang_path, "w")
		  if aFile
			content = aFile.syswrite(input[0])
		  else
			UI.messagebox (sUnableToWriteToFile + ": " + $lang_path)
		  end
	  end
	  
	  use_layer_name = true
	  if ((input == nil) || (input == false))
		use_layer_name = true 
	  else
		if (input[1] == $sEntityName)
		  use_layer_name = false
		else
		  use_layer_name = true
		end
	  end

	  ignore_less_than_size = input[2]
	  
	  
	  if ignore_less_than_size == nil
		ignore_less_than_size = 0
	  end
	  
	  ignore_less_than_size = ignore_less_than_size.to_l
	  
	  #puts ignore_less_than_size
	  
	  #name_xml = model_path + "/" + mname + ".xml"
	  file_name_xml = model_path + ".xml"
	  
	  file = File.new(file_name_xml,"w")

	  file.puts("<?xml version=\"1.0\"?>")
		file.puts("<data>") 
		file.puts("<parts>") 
	  
	  
	  for i in 0..selection.count - 1
		entity = selection[i]
		recursive_count(selection[i], true, file, use_layer_name, ignore_less_than_size)
	  end

		file.puts("</parts>") 
		file.puts("</data>")
	  file.close

	  uo["SuppressUnitsDisplay"] = saved_SuppressUnitsDisplay

	  UI.messagebox($sDataWrittenTo + ": \n\n" + file_name_xml + "  \n")

	end

    unless file_loaded?(__FILE__)
      menu = UI.menu('Plugins')
      menu.add_item('Cutting Optimization Pro exporter 1.7.3') {
        self.compute_entities_and_save_results
      }
      file_loaded(__FILE__)
    end
	
  end # module
end # module
