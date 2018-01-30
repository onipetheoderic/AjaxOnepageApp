class TodosController < ApplicationController
	def index
		@todos = Todo.all
	end

	def create
		#binding.pry#click the create button and check your terminal prompt. then type params, you would see all the params
		@todo = Todo.create(todo_params)
		#we can now use the instance variable in the javascript file
		#redirect_to root_path #currently after creating the todos we redirect, but the whole point of Ajax is to avoid redirecting
		#we now tell it to render javascript
		respond_to do |format|
			format.html { redirect_to root_path }#if it is an html request give out an html string response
			format.js { } #if it is a javascript request give out a javascript response
			#lets now tell our ajax request to send back javascript as well
#What is format.js actually doing
#When Rails sees that line of code, it will automatically look for a file with the path app/views/<controller name>/<action name>.js.erb. 
#In our example, it’s looking for app/views/todos/create.js.erb.
		end
	end

	def destroy
		@todo = Todo.find(params[:id])
		@todo.destroy	
		#lets tell the todo action how to respond to js
		respond_to do |format|
			format.html { redirect_to root_path }	
			format.js { }
		end
	end


	private

	def todo_params
		params.require(:todo).permit(:description, :priority)
	end
end
# but the params is not quite right, since we are using strong parameters, it should be at the top level
# by changing our ajax request to data: { todo: {description: description, priority: priority} } this probs is solved
# so we use a jquery method called serializeArray();