require 'spec_helper'

describe "Editting todo lists" do
	let!(:todo_lists) {TodoList.create(title: "Groceries", description: "Grocery List.")}

	def update_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is my todo list."

		todo_list = options[:todo_list]

		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: "New title"
		fill_in "Description", with: "New Description"
		click_button "Update Todo list"
	end

	it "updates a todo list successfully with correct information" do

		todo_lists = TodoList.create(title: "Groceries", description: "Grocery list.")
		update_todo_list todo_list: todo_lists,
						 title: "New title",
						 description: "New description"

		todo_lists.reload

		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_lists.title).to eq("New title")
		expect(todo_lists.description).to eq("New Description")
	end
end