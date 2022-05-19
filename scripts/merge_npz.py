#!/usr/bin/env python

import numpy as np

forwardTs=np.load('./sorted.bam.forward.Scores_per_TS.npz')
reverseTs=np.load('./sorted.bam.reverse.Scores_per_TS.npz')

matrix = np.concatenate([forwardTs['matrix'], reverseTs['matrix']])
labels = np.concatenate([forwardTs['labels']])

np.savez('mergedScores.npz', matrix=matrix,labels=labels)
