import os
import random
message = ['minor changes', 'new additions', 'bug fixes', 'changes', 'done for the day', 'made changes', 'new features', 'ui added', 'database changes', 'validation', 'fixed']
os.system("git add .")
os.system(f'git commit -m"{random.choice(message)}"')