# ExtjsRenderer

Rails 3 Renderer to send JSON compatible with Sencha Extjs 3+

## Usage

### ActiveRecord Relations

JSON root defaults to resource:

	Controller action:

	def index
		@items = Item.order('name')
		respond_with @items do |format|
			format.json { render :extjs => @items }
		end
	end

	Output:

	{"total":1,"item":[{"id":1,"name":"widget"}]}
	
Custom JSON root and to_json params:

	Controller action:

	def index
		@items = Item.order('name')
		respond_with @items do |format|
			format.json { render :extjs => @items, :root => "product", :only => [:name], :methods => [:custom] }
		end
	end

	Or

	def index
		@items = Item.order('name')
		respond_with @items do |format|
			format.json { render :extjs => @items, :root => "product", :except => [:id], :methods => [:custom] }
		end
	end

	Output:

	{"total":1,"product":[{"name":"widget","custom":"custom method output"}]}
	
### Single Resource

Root defaults to 'data' or :root => 'custom':

	Controller action:

		def edit
			@item = Item.find(params[:id])
			respond_with @items do |format|
				format.json { render :extjs => @item, :only => [:name], :methods => [:custom] }
			end
		end

	Output:

	{"success":true,"data":[{"name":"widget","custom":"custom method output"}]}