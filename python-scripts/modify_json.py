import json
import copy
import os
import time

# Please modify the below list of accepted attributes as per your requirements
attribute_accepted = ['id','name','supertype', 'level', 'hp', 'types', 'evolvesFrom', 'abilities', 'attacks', 'weaknesses', 'artist','images']

filename = ''

# Reading from the json file
with open('../Database-json/base1.json', 'r') as data_file:
    data = json.load(data_file)
    filename = os.path.basename(data_file.name)
print("\nFilename: ",filename)

print ("\nModifying the json object...")
pokemon_cards = []
for card in data:
	if card['supertype']=='PokÃ©mon':
		attribute_not_accepted = []
		for attribute in card:
			if attribute not in attribute_accepted:
				attribute_not_accepted.append(attribute)
		for attribute in attribute_not_accepted:
			card.pop(attribute, None)
		pokemon_cards.append(card)

time.sleep(2)
print("Json object modified\n")
print ("Number of cards in", filename, "file: ",len(data),'\n')
print ("Number of Pokemon cards in", filename, "file: ",len(pokemon_cards),'\n')


# Writing into the json file
# If you want to overwirte the original json file instead, please change the file name in the next line 
with open('base1_filtered.json', 'w') as data_file:
	filename = os.path.basename(data_file.name)
	print ("Writing the modified json object in the",filename,"file...")
	data = json.dump(pokemon_cards, data_file, indent=4)
time.sleep(2)
print (filename,"file updated successfully")
