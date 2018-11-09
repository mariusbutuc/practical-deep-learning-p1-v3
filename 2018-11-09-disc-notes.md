# Week 2/7: [Discussion session]
2018-11-08

## Support/template notebooks

* [lesson1-pets-template-empty.ipynb]
* [lesson2-download-template-empty.ipynb]

## Warm-up run 

* [lesson-empty-run.ipynb]
* The **purpose** is to not get stuck. It's not like a PhD study, learning from the bottom-up
* Be **persistent**! That's a good trait for learning AI. 

## Jupyter Notebook 

* `$ jupyter notebook`
* Use [`autoreload`] to reload modules before executing the code
* Secure the ssh connection to the jupyter notebook
* Extensions: for example, collapsible sections

## tmux

* Use [tmux] to persist the connection

## vim

* Use vim as it's already available on many machines

## aliases

@xufei shared these useful ones

```
alias update-fastai='conda update -c fastai fastai -y'

alias monitor-gpu='nvidia-smi --query-gpu=utilization.gpu,utilization.memory,memory.used --format=csv -l 3'
```

## conda

* Virtual environments
* Install local dependencies

```
conda install -c fastai fastai 

conda install pytorch torchvision -c pytorch
```


  [Discussion session]: https://www.meetup.com/Toronto-Data-Literacy-Group/events/ltwclqyxpblb/
  [tmux]: https://github.com/tmux/tmux/wiki
  [`autoreload`]: https://ipython.org/ipython-doc/3/config/extensions/autoreload.html#usage
