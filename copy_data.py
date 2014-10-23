import re, os, subprocess

trees_small_set = [[i for i in os.listdir('gdata_5') if 'tr_1' in i][0:40], [i for i in os.listdir('gdata_5') if 'tr_2' in i][0:20], [i for i in os.listdir('gdata_5') if 'tr_3' in i][0:20] ,[i for i in os.listdir('gdata_5') if 'tr_4' in i][0:20], [i for i in os.listdir('gdata_5') if 'tr_5' in i][0:10]]

def unlist(nested_list):
    out_list = []
    for i in nested_list:
        for k in i:
            out_list.append(k)
    return out_list

trees_small_set = unlist(trees_small_set)

if False:
    for i in trees_small_set:
        subprocess.call(['cp', 'gdata_5/'+i, 'gdata_6/'])
        print 'I copied %s' %(i)




trees_medium_set = [[i for i in os.listdir('gdata_5') if 'tr_1' in i][0:75], [i for i in os.listdir('gdata_5') if 'tr_2' in i][0:50], [i for i in os.listdir('gdata_5') if 'tr_3' in i][0:50] ,[i for i in os.listdir('gdata_5') if 'tr_4' in i][0:50], [i for i in os.listdir('gdata_5') if 'tr_5' in i][0:25]]

trees_medium_set = unlist(trees_medium_set)

if False:
    for i in trees_medium_set:
        subprocess.call(['cp', 'gdata_5/'+i, 'gdata_7/'])
        print 'I copied %s' %(i)
