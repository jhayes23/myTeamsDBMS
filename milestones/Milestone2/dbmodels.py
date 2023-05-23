# Your code to model your objects to handle the data from your database goes here.
import database as db
import bot_commands
import dbmodels
# # Interface DATABASEACTIONS
# # class DatabaseActions:
# #   def load(id):
# #     pass

# #   def sync():
# #     pass
# # class Employee(Database):
class Client:
  def __init__ (self):
    self.id = None
    self.name = None
    self.phone = None
    self.zip = None
    self.city = None
    self.state = None
    self.load()

  def load(self):
    query = """SELECT name,phone,address,zip,city,state FROM myteamsdb.clients
JOIN myteamsdb.invoices on clients.client_id = invoices.client_id
WHERE due_date < NOW();"""
    data = self.select(query)
    data = data[0];
    self.name = data['name']
#     self.company = data['Company.name']


# employee = Employee(1)

def response(msg):
  response_data = None #Null
  msg_data = msg.split()
  bot_command = msg_data[0]
  arguments = msg_data[1:]

  if bot_command in bot_commands.past_due_clients:
      if len(arguments) == 0:
           client = Client()
           response_data = client.name
      else:
           return "This command requires no arguments"
  elif bot_command in bot_commands.employees_for_company_region:
        if len(arguments) == 1:
           region = arguments[0]
           response_data = "employees_for_company_region"
        else:
           return "This command requires only a region argument"
  elif bot_command in bot_commands.recent_applicants_for_position:
        if len(arguments) == 2:
           position = arguments[0]
           time = arguments[1]
           response_data = "recent_applicants_for_position"
        else:
           return "This command requires only a position and time argument"
  elif bot_command in bot_commands.manager_priority_projects:
        if len(arguments) == 2:
           priority = arguments[0]
           manager = arguments[0]
           response_data = "manager_priority_projects"
        else:
           return "This command requires only a priority and manager argument"
  elif bot_command in bot_commands.active_client_projects:
        if len(arguments) == 1:
           client = arguments[0]
           response_data = "active_client_projects"
        else:
           return "This command requires only a client argument"
  elif bot_command in bot_commands.list_candidate_docs:
        if len(arguments) == 1:
           candidate = arguments[0]
           response_data = "list_candidate_docs"
        else:
           return "This command requires only a candidate argument"
  elif bot_command in bot_commands.calculate_income:
        if len(arguments) == 3:
           employee = arguments[0]
           time_start = arguments[1]
           time_end = arguments[2]
           response_data = "calculate_income"
        else:
           return "This command requires only an employee, time_start, time_end argument"
  elif bot_command in bot_commands.dep_employee_contact_info:
        if len(arguments) == 1:
           department = arguments[0]
           response_data = "dep_employee_contact_info"
        else:
           return "This command requires only a department argument"
  elif bot_command in bot_commands.inactive_employee_addresses:
        if len(arguments) == 1:
           year = arguments[0]
           response_data = "inactive_employee_addresses"
        else:
           return "This command requires only a year argument"
  elif bot_command in bot_commands.internal_applicants:
        if len(arguments) == 1:
           job = arguments[0]
           time = arguments[1]
           response_data = "internal_applicants"
        else:
           return "This command requires only a position and time argument"
  elif bot_command in bot_commands.department_available_pos:
        if len(arguments) == 1:
           department = arguments[0]
           response_data = "department_available_pos"
        else:
           return "This command requires a only department argument"
  elif bot_command in bot_commands.manager_projects_for_client:
        if len(arguments) == 2:
           manager = arguments[0]
           client = arguments[1]
           response_data = "manager_projects_for_client"
        else:
           return "This command requires a only manager and client argument"
  elif bot_command in bot_commands.unassigned_clients:
        if len(arguments) == 1:
           clients = arguments[0]
           response_data = "unassigned_clients"
        else:
           return "This command requires only a client argument"
  elif bot_command in bot_commands.manager_candidate_notes:
        if len(arguments) == 2:
           manager = arguments[0]
           candidate = arguments[0]
           response_data = "manager_candidate_notes"
        else:
           return "This command requires only a manager and candidate argument"
  elif bot_command in bot_commands.employee_projects:
        if len(arguments) == 1:
           employee = arguments[0]
           response_data = "employee_project"
        else:
           return "This command requires only a employee argument"
  elif bot_command in bot_commands.cost_of_laber_between:
        if len(arguments) == 2:
           start = arguments[0]
           end = arguments[1]
           response_data = "cost_of_laber_between"
        else:
           return "This command requires only a start and end argument"
  elif bot_command in bot_commands.candidate_apps:
        if len(arguments) == 1:
           candidate = arguments[0]
           response_data = "candidate_apps"
        else:
           return "This command requires only a candidate argument"
  elif bot_command in bot_commands.client_dues:
        if len(arguments) == 1:
           client = arguments[0]
           response_data = "client_dues"
        else:
           return "This command requires only a client argument"
  if response_data:
      return response_data
  return "Your error message"