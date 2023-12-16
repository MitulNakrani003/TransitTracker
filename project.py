import pymysql
import pwinput
import matplotlib.pyplot as plt
import numpy as np


def printMenuOptions():
    print("\n--------------------------------------------------------------")
    print("Please select one of the following options (If Clicked Wrong Operation, Type quit when prompted to go to Main Menu)")
    print(("1. Add Charlie Card").upper())
    print(("2. View Charlie Cards").upper())
    print(("3. Delete Charlie Card").upper())
    print(("4. Add Balance to Charlie Card").upper())
    print(("5. View Travel Log").upper())
    print(("6. Book A Journey").upper())
    print(("7. Add Credit Card").upper())
    print(("8. Edit Profile Information").upper())
    print(("9. Update Journey Stations").upper())
    print(("10. Delete Credit Card").upper())
    print(("11. Data visualizations").upper())
    print(("12. Sign Out").upper())


def showLoginOptions():
    print("\n--------------------------------------------------------------")
    print("Please select one of the following options")
    print(("1. Existing User").upper())
    print(("2. Create Account").upper())
    print(("3. Quit").upper())


def visualizeDataOptions():
    print("\n----------------------------------------------------------------")
    print("Please select one of the following options")
    print(("1. Frequency of Every Transit Line").upper())
    print(("2. Frequency of Travelled Stations").upper())
    print(("3. Charlie Card Issued Per Type").upper())
    print(("4. View Journey Statistics by Day of Week").upper())
    print(("5. Back to Main Menu").upper())


def checkDuplicateUsername(username):
    try:
        c1 = connection.cursor()
        sql_query = f"SELECT is_username_taken(%s)"
        c1.execute(sql_query, (username))
        isPresentVal = c1.fetchall()
        if isPresentVal[0][f"is_username_taken('{username}')"] == 1:
            return True
        else:
            return False
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def createNewUser(username, password, first_name, last_name, street_no, street_name, city, state, zip_code, email, contact_no, dob):
    try:
        c1 = connection.cursor()
        sql_query = f"CALL create_user(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
        c1.execute(sql_query, (username, password, first_name, last_name,
                   street_no, street_name, city, state, zip_code, email, contact_no, dob))
        return True
    except pymysql.Error as e:
        print(e)
        return False
    finally:
        c1.close()


def addNewCharlieCardButton(cardType, cardNumber, cardIssueDate):
    try:
        c1 = connection.cursor()
        c1.callproc('add_charlie_card',
                    (active_user[0], cardType, cardNumber, cardIssueDate,))
        print("Charlie Card Added Successfully")
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def viewCharliecardsButton():
    try:
        c1 = connection.cursor()
        c1.callproc('get_charlie_card', (active_user[0], ))
        charlie_cards_data = []
        for x in c1.fetchall():
            charlie_cards_data.append(x)
        print("| {:<16} | {:<14} | {:<20} | {:<20} |".format(
            "Card Number", "Card Type", "Card Balance", "Card Issue Date"))
        print("|" + "-" * 18 + "|" + "-" * 16 +
              "|" + "-" * 22 + "|" + "-" * 22 + "|")
        for card in charlie_cards_data:
            print("| {:<16} | {:<14} | {:<19}$ | {:<20} |".format(
                card["card_id"], card["card_type"], card["balance"], card["card_issue_date"].strftime('%Y-%m-%d')))
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def deleteCharlieCardButton(cardNumber):
    try:
        c1 = connection.cursor()
        c1.callproc('delete_charlie_card', (active_user[0], cardNumber,))
        print("Charlie Card Deleted Successfully")
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def addCreditCardButton(credit_card_no, credit_card_type, credit_carholder_name, expiry_date):
    try:
        c1 = connection.cursor()
        c1.callproc('add_credit_card', (active_user[0], credit_card_no,
                    credit_card_type, credit_carholder_name, expiry_date,))
        print("Credit Card Added Successfully")
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def getCCOptionsForjourney():
    try:
        c1 = connection.cursor()
        c1.callproc('get_charlie_card', (active_user[0], ))
        charlie_cards_data_number = []
        charlie_cards_data_balance = []
        final = []
        for x in c1.fetchall():
            charlie_cards_data_number.append(x["card_id"])
            charlie_cards_data_balance.append(x["balance"])
        final.append(charlie_cards_data_number)
        final.append(charlie_cards_data_balance)
        return final
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def getLineOptions():
    try:
        c1 = connection.cursor()
        c1.callproc('get_lines', ())
        temp = []
        for line in c1.fetchall():
            temp.append(list(line.values()))
        return temp
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def getStationsForLine(trnsit_line):
    try:
        c1 = connection.cursor()
        c1.callproc('get_stations', (trnsit_line,))
        temp = []
        for line in c1.fetchall():
            temp.append(list(line.values()))
        return temp
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def bookJourneyButton(username, journey_date, charlie_card_no, trnsit_line, startStation, endStation):
    try:
        c1 = connection.cursor()
        c1.callproc('book_journey', (username, charlie_card_no,
                    trnsit_line, startStation, endStation, journey_date,))
        print("Journey Booked Successfully")
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def getCreditCard():
    try:
        c1 = connection.cursor()
        c1.callproc('get_credit_card', (active_user[0], ))
        temp = []
        for line in c1.fetchall():
            temp.append(list(line.values()))
        return temp
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def allBalanceToCC(creditCardNo, charlie_card_no, balance_to_add):
    try:
        c1 = connection.cursor()
        c1.callproc(
            'add_balance', (active_user[0], creditCardNo, charlie_card_no, balance_to_add,))
        print("Balance Added Successfully")
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def viewJourneyLogButton():
    try:
        c1 = connection.cursor()
        c1.callproc('user_journey', (active_user[0], ))
        journey_log_data = []
        for x in c1.fetchall():
            journey_log_data.append(x)

        c2 = connection.cursor()
        sql_query = f"SELECT user_journey_count(%s)"
        c2.execute(sql_query, (active_user[0]))
        total_journeys = []
        for x in c2.fetchall():
            total_journeys.append(list(x.values()))

        print("Total Journeys: " + str(total_journeys[0][0]))
        print("| {:<16} | {:<22} | {:<17} | {:<20} | {:<20} |".format(
            "Journey Date", "Charlie Card Number", "Travel Line", "Start Station", "End Station"))
        print("|" + "-" * 18 + "|" + "-" * 24 + "|" + "-" *
              19 + "|" + "-" * 22 + "|" + "-" * 22 + "|")
        for card in journey_log_data:
            print("| {:<16} | {:<22} | {:<17} | {:<20} | {:<20} |".format(
                card["journey_date"].strftime('%Y-%m-%d'), card["card_id"], card["travel_line"], card["start_station"], card["end_station"]))
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def getUserProfileInfo():
    try:
        c1 = connection.cursor()
        c1.callproc('get_user_details', (active_user[0], ))
        userProfileData = []
        for x in c1.fetchall():
            userProfileData.append(x)
        return userProfileData
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def getUserJourneys():
    try:
        c1 = connection.cursor()
        c1.callproc('user_journey', (active_user[0], ))
        journey_log_data = []
        for x in c1.fetchall():
            journey_log_data.append(x)
        return journey_log_data
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def viewJourneyStatisticsByDayOfWeekData():
    try:
        c1 = connection.cursor()
        c1.callproc('journey_by_weekday', ())
        journey_log_data = {}
        for x in c1.fetchall():
            journey_log_data[x['day_of_week']
                             ] = x['COUNT(journey.journey_date)']
        return journey_log_data
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def charlieCardIssuedPerTypeData():
    try:
        c1 = connection.cursor()
        c1.callproc('users_for_charlie_card_type', ())
        journey_log_data = {}
        for x in c1.fetchall():
            journey_log_data[x['card_type']] = x['COUNT(cc.card_id)']
        return journey_log_data
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def viewStartStationDataFrequency(trnsit_line):
    try:
        c1 = connection.cursor()
        c1.callproc('line_sstart_station_total_journeys', (trnsit_line,))
        temp = {}
        for line in c1.fetchall():
            temp[line['sn_']] = line['count(journey_id)']
        return temp
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def viewEndStationDataFrequency(trnsit_line):
    try:
        c1 = connection.cursor()
        c1.callproc('line_end_station_total_journeys', (trnsit_line,))
        temp2 = []
        temp = {}
        for line in c1.fetchall():
            temp[line['sn_']] = line['count(journey_id)']
            temp2.append(line)
        return temp
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def getLineFrequency():
    try:
        c1 = connection.cursor()
        c1.callproc('line_total_journeys', ())
        temp = {}
        for line in c1.fetchall():
            temp[(list(line.values()))[0]] = (list(line.values()))[1]
        return temp
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


def dataVisualization():
    visualChoise = ""
    while(visualChoise != "5"):
        visualizeDataOptions()
        visualChoise = input("Enter your choice: ")
        if(visualChoise == "1"):
            print("\n")
            lineFreq = getLineFrequency()
            line_name = []
            line_freq = []
            for key, value in lineFreq.items():
                line_name.append(key)
                line_freq.append(value)
            plt.figure(figsize=(8, 6))
            plt.bar(line_name, line_freq, color='skyblue')
            plt.xlabel('Transit Lines')
            plt.ylabel('Number of Journeys')
            plt.title('Total Number of Journeys for Each Transit Line')
            plt.xticks(rotation=45, ha='right')
            plt.tight_layout()
            plt.show()
        elif(visualChoise == "2"):
            print("\n")
            lineOptions = getLineOptions()
            print("\n")
            print("Transit Lines")
            for x in range(len(lineOptions)):
                print(f"{x+1}. {lineOptions[x][0]}")
            chosen_line = input("Choose Line: ")
            trnsit_line = lineOptions[int(chosen_line)-1][0]

            startData = viewStartStationDataFrequency(trnsit_line)
            endData = viewEndStationDataFrequency(trnsit_line)
            stations = []
            startfreq = []
            endfreq = []
            for key, value in startData.items():
                stations.append(key)
                startfreq.append(value)
            for key, value in endData.items():
                endfreq.append(value)

            X_axis = np.arange(len(stations))
            plt.figure(figsize=(16, 5))
            plt.bar(X_axis - 0.2, startfreq, width=0.4,
                    label='Start Stations', color='r')
            plt.bar(X_axis + 0.2, endfreq, width=0.4,
                    label='End Stations', color='b')
            plt.xticks(X_axis, stations)
            plt.xlabel('Train Stations')
            plt.ylabel('Number of Journeys')
            plt.title('Total Number of Journeys for Each Station')
            plt.legend()
            plt.show()
        elif(visualChoise == "3"):
            print("\n")
            cardData = charlieCardIssuedPerTypeData()
            card_type = []
            card_count = []
            for key, value in cardData.items():
                card_type.append(key)
                card_count.append(value)
            plt.figure(figsize=(6, 5))
            plt.bar(card_type, card_count, color='skyblue')
            plt.xlabel('Charlie Card Type')
            plt.ylabel('Total Number of Cards')
            plt.title('Total Number of Charlie Cards Issued Per Type')
            plt.xticks(rotation=45, ha='right')
            plt.tight_layout()
            plt.show()
        elif(visualChoise == "4"):
            print("\n")
            dayWiseData = viewJourneyStatisticsByDayOfWeekData()
            days_of_week = []
            freq_on_day = []
            for key, value in dayWiseData.items():
                days_of_week.append(key)
                freq_on_day.append(value)
            plt.figure(figsize=(8, 6))
            plt.bar(days_of_week, freq_on_day, color='skyblue')
            plt.xlabel('Days of the Week')
            plt.ylabel('Number of Journeys')
            plt.title('Number of Journeys for Each Day of the Week')
            plt.xticks(rotation=45, ha='right')
            plt.tight_layout()
            plt.show()


def deleteCreditCardButton(creditCardNo):
    try:
        c1 = connection.cursor()
        c1.callproc('delete_credit_card', (active_user[0], creditCardNo,))
        print("Credit Card Deleted Successfully")
    except pymysql.Error as e:
        print(e)
    finally:
        c1.close()


active_user = []


def innerMenu():
    optionsChoice = ""
    while(optionsChoice != "12"):
        printMenuOptions()
        optionsChoice = input("Enter your choice: ")
        if optionsChoice == "1":
            print("\n")
            temp = []
            try:
                c1 = connection.cursor()
                c1.callproc('get_charlie_card_type', ())
                isPresentVal = c1.fetchall()
                for x in isPresentVal:
                    temp.append(list(x.values()))
            except pymysql.Error as e:
                print(e)
            finally:
                c1.close()
            temp2 = []
            for x in temp:
                temp2.append(x[0])
            charlie_card_no = input("Enter Charlie Card Number: ")
            if(charlie_card_no == "quit"):
                continue
            card_issue_date = input("Enter Card Issue Date (YYYY-MM-DD): ")
            if(card_issue_date == "quit"):
                continue
            card_type = input(f"Enter Card Type: ({temp2}): ")
            if(card_type == "quit"):
                continue
            addNewCharlieCardButton(
                card_type, charlie_card_no, card_issue_date)
        elif optionsChoice == "2":
            print("\n")
            viewCharliecardsButton()
        elif optionsChoice == "3":
            print("\n")
            charlieCards = getCCOptionsForjourney()
            print("\n")
            print("Available Charlie Cards")
            if(len(charlieCards[0]) == 0):
                print("No Charlie Cards Available, Add a Charlie Card First!!!")
                continue
            for x in range(len(charlieCards[0])):
                print(
                    f"{x+1}. {charlieCards[0][x]} - Available balance: ${charlieCards[1][x]}")
            chosen_charlie_card_no = input("Choose Charlie Card: ")
            if(chosen_charlie_card_no == "quit"):
                continue
            charlie_card_no = charlieCards[0][int(chosen_charlie_card_no)-1]
            # charlie_card_no = input("Enter Charlie Card Number: ")
            if(charlie_card_no == "quit"):
                continue
            deleteCharlieCardButton(charlie_card_no)
        elif optionsChoice == "4":
            print("\n")
            creditCards = getCreditCard()
            print("Available Credit Cards")
            if(len(creditCards) == 0):
                print("No Credit Cards Available, Add a Credit Card First!!!")
                continue
            for x in range(len(creditCards)):
                print(
                    f"{x+1}. {'-'.join([(creditCards[x][0])[i:i+4] for i in range(0, 16, 4)])}")
            chosen_credit_card_no = input("Choose Credit Card: ")
            if(chosen_credit_card_no == "quit"):
                continue
            creditCardNo = creditCards[int(chosen_credit_card_no)-1][0]
            cvv = input("Enter Credit Card CVV: ")
            charlieCards = getCCOptionsForjourney()
            print("\n")
            print("Available Charlie Cards")
            if(len(charlieCards[0]) == 0):
                print("No Charlie Cards Available, Add a Charlie Card First!!!")
                continue
            for x in range(len(charlieCards[0])):
                print(
                    f"{x+1}. {charlieCards[0][x]} - Available balance: ${charlieCards[1][x]}")
            chosen_charlie_card_no = input("Choose Charlie Card: ")
            if(chosen_charlie_card_no == "quit"):
                continue
            charlie_card_no = charlieCards[0][int(chosen_charlie_card_no)-1]

            print("\n")
            balance_to_add = input("Enter Amount to Add: ")
            if(balance_to_add == "quit"):
                continue

            allBalanceToCC(creditCardNo, charlie_card_no, balance_to_add)
        elif optionsChoice == "5":
            print("\n")
            viewJourneyLogButton()
        elif optionsChoice == "6":
            print("\n")
            journey_date = input("Enter Journey Date (YYYY-MM-DD): ")
            if(journey_date == "quit"):
                continue
            charlieCards = getCCOptionsForjourney()
            print("\n")
            print("Available Charlie Cards")
            if(len(charlieCards[0]) == 0):
                print("No Charlie Cards Available, Add a Charlie Card First!!!")
                continue
            for x in range(len(charlieCards[0])):
                print(
                    f"{x+1}. {charlieCards[0][x]} - Available balance: ${charlieCards[1][x]}")
            chosen_charlie_card_no = input("Choose Charlie Card: ")
            if(chosen_charlie_card_no == "quit"):
                continue
            charlie_card_no = charlieCards[0][int(chosen_charlie_card_no)-1]

            lineOptions = getLineOptions()
            print("\n")
            print("Transit Lines")
            for x in range(len(lineOptions)):
                print(f"{x+1}. {lineOptions[x][0]}")
            chosen_line = input("Choose Line: ")
            if(chosen_line == "quit"):
                continue
            trnsit_line = lineOptions[int(chosen_line)-1][0]

            stationOptions = getStationsForLine(trnsit_line)
            print("\n")
            print("Start Stations")
            for x in range(len(stationOptions)):
                print(f"{x+1}. {stationOptions[x][0]}")
            chosen_start_station = input("Choose Start Station: ")
            if(chosen_start_station == "quit"):
                continue
            startStation = stationOptions[int(chosen_start_station)-1][0]
            print("\n")

            print("End Stations")
            for x in range(len(stationOptions)):
                print(f"{x+1}. {stationOptions[x][0]}")
            chosen_end_station = input("Choose End Station: ")
            if(chosen_end_station == "quit"):
                continue
            endStation = stationOptions[int(chosen_end_station)-1][0]

            bookJourneyButton(
                active_user[0], journey_date, charlie_card_no, trnsit_line, startStation, endStation)
        elif optionsChoice == "7":
            print("\n")
            credit_card_no = input("Enter Credit Card Number (16 Digits): ")
            if(credit_card_no == "quit"):
                continue
            credit_card_type = input(
                "Enter Credit Card Type: (VISA, MASTERCARD, AMEX): ")
            if(credit_card_type == "quit"):
                continue
            credit_carholder_name = input("Enter Credit Card Holder Name: ")
            if(credit_carholder_name == "quit"):
                continue
            expiry_date = input("Enter Expiry Date (YYYY-MM-DD): ")
            if(expiry_date == "quit"):
                continue
            addCreditCardButton(credit_card_no, credit_card_type,
                                credit_carholder_name, expiry_date)
        elif optionsChoice == "8":
            print("\n")
            userData = getUserProfileInfo()
            print("Existing User Profile Information")
            print("First Name: " + userData[0]["firstname"])
            print("Last Name: " + userData[0]["lastname"])
            print("Email: " + userData[0]["email"])
            print("Contact Number: " + userData[0]["contact_no"])
            print("Date of Birth: " +
                  userData[0]["date_of_birth"].strftime('%Y-%m-%d'))

            print("\n\nValue to be updated")
            print("1. First Name")
            print("2. Last Name")
            print("3. Email")
            print("4. Contact Number")
            print("5. Date of Birth")
            valueChoice = input("Enter your choice: ")
            if valueChoice == "quit":
                continue

            if valueChoice == "1":
                new_first_name = input("Enter new First Name: ")
                try:
                    c1 = connection.cursor()
                    c1.callproc('update_user_details', (active_user[0], new_first_name, userData[0]["lastname"],
                                userData[0]["email"], userData[0]["contact_no"], userData[0]["date_of_birth"],))
                    print("First Name Updated Successfully")
                except pymysql.Error as e:
                    print(e)
                finally:
                    c1.close()
            elif valueChoice == "2":
                new_last_name = input("Enter new Last Name: ")
                try:
                    c1 = connection.cursor()
                    c1.callproc('update_user_details', (active_user[0], userData[0]["firstname"], new_last_name,
                                userData[0]["email"], userData[0]["contact_no"], userData[0]["date_of_birth"],))
                    print("Last Name Updated Successfully")
                except pymysql.Error as e:
                    print(e)
                finally:
                    c1.close()
            elif valueChoice == "3":
                new_email = input("Enter new Email: ")
                try:
                    c1 = connection.cursor()
                    c1.callproc('update_user_details', (active_user[0], userData[0]["firstname"], userData[0]
                                ["lastname"], new_email, userData[0]["contact_no"], userData[0]["date_of_birth"],))
                    print("Email Updated Successfully")
                except pymysql.Error as e:
                    print(e)
                finally:
                    c1.close()
            elif valueChoice == "4":
                new_contact_no = input("Enter new Contact Number: ")
                try:
                    c1 = connection.cursor()
                    c1.callproc('update_user_details', (active_user[0], userData[0]["firstname"], userData[0]
                                ["lastname"], userData[0]["email"], new_contact_no, userData[0]["date_of_birth"],))
                    print("Contact Number Updated Successfully")
                except pymysql.Error as e:
                    print(e)
                finally:
                    c1.close()
            elif valueChoice == "5":
                new_dob = input("Enter new Date of Birth (YYYY-MM-DD): ")
                try:
                    c1 = connection.cursor()
                    c1.callproc('update_user_details', (active_user[0], userData[0]["firstname"],
                                userData[0]["lastname"], userData[0]["email"], userData[0]["contact_no"], new_dob,))
                    print("Date of Birth Updated Successfully")
                except pymysql.Error as e:
                    print(e)
                finally:
                    c1.close()
            else:
                print("Invalid Choice")
        elif optionsChoice == "9":
            print("\n")
            userJourneys = getUserJourneys()
            print("Journeys")
            print("| {:<5} | {:<16} | {:<22} | {:<17} | {:<20} | {:<20} |".format("No,",
                                                                                  "Journey Date", "Charlie Card Number", "Travel Line", "Start Station", "End Station"))
            print("|" + "-" * 7 + "|" + "-" * 18 + "|" + "-" * 24 +
                  "|" + "-" * 19 + "|" + "-" * 22 + "|" + "-" * 22 + "|")
            for x in range(len(userJourneys)):
                print("| {:<5} | {:<16} | {:<22} | {:<17} | {:<20} | {:<20} |".format(x+1,
                                                                                      userJourneys[x]["journey_date"].strftime('%Y-%m-%d'), userJourneys[x]["card_id"], userJourneys[x]["travel_line"], userJourneys[x]["start_station"], userJourneys[x]["end_station"]))
            chosen_journey = input("Choose Journey: ")
            journeyToUpdate = userJourneys[int(chosen_journey)-1]["journey_id"]
            journeyToUpdateLine = userJourneys[int(
                chosen_journey)-1]["travel_line"]

            print("\nUpdate Options")
            print("1. Start Station")
            print("2. End Station")
            updateChoice = input("Enter your choice: ")
            if updateChoice == "quit":
                continue

            if updateChoice == "1":
                stationOptions = getStationsForLine(journeyToUpdateLine)
                print("\n")
                print("Start Stations")
                for x in range(len(stationOptions)):
                    print(f"{x+1}. {stationOptions[x][0]}")
                chosen_start_station = input("Choose Start Station: ")
                startStation = stationOptions[int(chosen_start_station)-1][0]
                try:
                    c1 = connection.cursor()
                    c1.callproc('update_journey_details', (active_user[0], journeyToUpdate, startStation, userJourneys[int(
                        chosen_journey)-1]["end_station"],))
                    print("Start Station Updated Successfully")
                except pymysql.Error as e:
                    print(e)
                finally:
                    c1.close()
            if updateChoice == "2":
                stationOptions = getStationsForLine(journeyToUpdateLine)
                print("\n")
                print("End Stations")
                for x in range(len(stationOptions)):
                    print(f"{x+1}. {stationOptions[x][0]}")
                chosen_end_station = input("Choose END Station: ")
                endStation = stationOptions[int(chosen_end_station)-1][0]
                try:
                    c1 = connection.cursor()
                    c1.callproc('update_journey_details', (active_user[0], journeyToUpdate, userJourneys[int(
                        chosen_journey)-1]["start_station"], endStation,))
                    print("End Station Updated Successfully")
                except pymysql.Error as e:
                    print(e)
                finally:
                    c1.close()
        elif optionsChoice == "10":
            print("\n")
            creditCards = getCreditCard()
            print("Available Credit Cards")
            if(len(creditCards) == 0):
                print("No Credit Cards Available, Add a Credit Card First!!!")
                continue
            for x in range(len(creditCards)):
                print(
                    f"{x+1}. {'-'.join([(creditCards[x][0])[i:i+4] for i in range(0, 16, 4)])}")
            chosen_credit_card_no = input("Choose Credit Card to Delete: ")
            if(chosen_credit_card_no == "quit"):
                continue
            creditCardNo = creditCards[int(chosen_credit_card_no)-1][0]

            deleteCreditCardButton(creditCardNo)
        elif optionsChoice == "11":
            print("\n")
            dataVisualization()
        elif optionsChoice == "12":
            active_user.clear()
            return
        else:
            print("Invalid Choice")


def mainFunc():
    print("\n\n############################################################")
    print("######## -- Welcome to the MBTA Transit Tracker -- #########")
    print("############################################################")
    loginChoice = ''
    while loginChoice != '3':
        showLoginOptions()
        loginChoice = input("Enter your choice: ")
        if loginChoice == '1':
            print("\n")
            username = input("Enter Username: ")
            password = pwinput.pwinput(prompt='Enter Password: ', mask='*')
            try:
                c1 = connection.cursor()
                sql_query = f"SELECT if_user_exists(%s,%s)"
                c1.execute(sql_query, (username, password))
                isPresentVal = c1.fetchall()
                if isPresentVal[0][f"if_user_exists('{username}','{password}')"] == 1:
                    active_user.append(username)
                    innerMenu()
                else:
                    print("Error in Credentials Username or Password Incorrect !!!!")
            except pymysql.Error as e:
                print(e)
            finally:
                c1.close()
        elif loginChoice == '2':
            print("\n")
            username = input("Enter Username: ")
            while(checkDuplicateUsername(username) == True):
                print("\nUsername Already Taken")
                username = input("Enter Username: ")
            password = pwinput.pwinput(prompt='Enter Password: ', mask='*')
            first_name = input("Enter First Name: ")
            last_name = input("Enter Last Name: ")
            print("--- Address Information ---")
            street_no = input("Enter Street No.: ")
            street_name = input("Enter Street Name: ")
            city = input("Enter City: ")
            state = input("Enter State (XX): ")
            zip_code = input("Enter Zip Code: ")
            print("--- Contact Information ---")
            email = input("Enter Email: ")
            contact_no = input("Enter Contact Number: ")
            dob = input("Enter Date of Birth (YYYY-MM-DD): ")
            ack = createNewUser(username, password, first_name, last_name, street_no.upper(
            ), street_name.upper(), city.upper(), state.upper(), zip_code, email, contact_no, dob)
            if(ack == True):
                print("User Created Successfully")
            else:
                print("Error in Creating User!!!")
        elif loginChoice == '3':
            break
        else:
            print("Invalid Choice")


flag = True
while(flag):
    username = input("Enter (MySQL) Database Username To Connect: ")
    pword = input("Enter (MySQL) Database Password: ")
    try:
        connection = pymysql.connect(
            host="localhost",
            user=username,
            password=pword,
            database='transit_tracker',
            cursorclass=pymysql.cursors.DictCursor,
            autocommit=True)
        print("Database Connected Successfully")
        mainFunc()
        flag = False
        break
    except pymysql.Error as e:
        print("Error in Connecting to Database, User Name or Password Incorrect!!!\n")
        code, msg = e.args
    finally:
        continue
