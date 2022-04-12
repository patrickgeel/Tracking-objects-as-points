import pandas as pd
import os
import seaborn as sns

dir = os.getcwd()
print("Current dir: ", dir)
files = os.listdir()

total_array = []
for file in files:
    if ".txt" in file:
        filename = file
        with open(file=filename) as f:
            lines = f.readlines()

        start,stop = [],[]
        for i,l in enumerate(lines):
            if "Rcll" in l and "Prcn" in l:
                start.append(i)
            elif "OVERALL" in l:
                stop.append(i)
        r_split = []
        # Get the raw results
        res_raw = lines[start[0]:stop[0]+1]
        for r in res_raw:
            r_split.append(r.split())
        r_split[0].insert(0,"Dataset")
        colname = r_split[0]
        res_df = pd.DataFrame(r_split).drop(index=0)
        res_df.columns = colname

        # Save File to CSV
        fname = filename.split('.txt')[0]
        savename= fname +'.csv'
        print("Writing results to file: ", dir + '//'+ savename )
        # Write data to run data to CSV
        res_df.to_csv(dir + '//'+ savename, index=False)
        
        # Extracting run data to build a total table
        run_data = res_df.loc[res_df.Dataset=="OVERALL"].values[0]
        # Change name of the run
        run_data[0] = fname
        # Store data in array
        total_array.append(run_data)

# Create a total dataframe and write to csv
total_df = pd.DataFrame(total_array,columns=colname)
print("Writing results to file: ", dir + '//'+ "Total_data.csv" )
total_df.to_csv(dir + '\\' + "Total_data.csv", index=False)

print(total_df)


# sns.barplot(total_df)