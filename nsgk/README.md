To run the analysis:

  $ virtualenv -p /usr/bin/python2.7 venv
  $ source venv/bin/activate
  $ pip install --upgrade pip
  $ pip install -r requirements.txt
  $ python analysis.py
  $ deactivate

You will see output like this:

  $ time python analysis.py 
  1
  2
  .
  .
  .
  181
  182
  183

When I timed it on my laptop
 
  $ time python analysis.py 

it took

  real    45m1.040s
  user    44m52.698s
  sys     0m8.715s

To delete the virtual environment:

  $ rm -rf venv
