from __future__ import print_function, absolute_import, division

import csv

import numpy as np

from permute.data import nsgk
from permute.irr import simulate_ts_dist, simulate_npc_dist


x = nsgk()
time_stamps = np.array([36, 32, 35, 37, 31, 35, 40, 32])

# Summary statistics per video
video_means = np.empty((0, 8))
video_sd = np.empty((0, 8))
for i in range(len(x)):
    temp_mean = []
    temp_sd = []
    for j in range(8):
        temp_mean.append(np.mean(x[i][j]))
        temp_sd.append(np.sqrt(np.var(x[i][j])))
    video_means = np.vstack((video_means, temp_mean))
    video_sd = np.vstack((video_sd, temp_sd))


# IRR results
category = []
video_pval = np.empty((0, 8))
video_conc = np.empty((0, 8))
for i in range(len(x)):   # loop over categories
    print(i + 1)
    d = []          # list of the permutation distributions for each video
    tst = []        # list of test statistics for each video
    vid_temp = []
    for j in range(len(x[i])):  # loop over videos
        res = simulate_ts_dist(x[i][j], keep_dist=True)
        d.append(res['dist'])
        tst.append(res['obs_ts'])
        vid_temp.append(res['pvalue'])
    video_pval = np.vstack((video_pval, vid_temp))
    video_conc = np.vstack((video_conc, tst))
    perm_distr = np.asarray(d).transpose()
    category.append(
        simulate_npc_dist(perm_distr, size=time_stamps,
                          obs_ts=tst, keep_dist=False))

category_pvalues = []
for i in range(len(category)):
    category_pvalues.append(category[i]['pvalue'])
category_pvalues = np.array(category_pvalues).transpose()

# Put results into a matrix
nsgk_res = np.concatenate((np.array(range(len(x) + 1))[1:][:, None],
                           category_pvalues[:, None],
                           video_pval, video_conc,
                           video_means, video_sd), axis=1)

nsgk_colnames = ['category', 'overall_pvalue']
for i in range(8):
    nsgk_colnames.append('video' + repr(i + 1) + 'pvalue')
for i in range(8):
    nsgk_colnames.append('video' + repr(i + 1) + 'concordance')
for i in range(8):
    nsgk_colnames.append('video' + repr(i + 1) + 'mean')
for i in range(8):
    nsgk_colnames.append('video' + repr(i + 1) + 'sd')


# Write to csv
with open('nsgk_results.csv', 'wb') as csvfile:
    writer = csv.writer(csvfile, delimiter=',')
    writer.writerow(nsgk_colnames)
    for row in nsgk_res:
        writer.writerow(row)
