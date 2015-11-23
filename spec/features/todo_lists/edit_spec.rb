require 'spec_helper'

describe "Editting todo lists" do
	it "updates a todo list successfully with the correct information" do
		todo_lists = TodoList.create(title: "Groceries", description: "Grocery list.")

		visit "/todo_lists"
		within "#todo_list_#{todo_lists.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: "New title"
		fill_in "Description", with: "New Description"
		click_button "Update Todo list"

		todo_lists.reload

		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_lists.title).to eq("New title")
		expect(todo_lists.description).to eq("New Description")
	end
end