---
output:
  pdf_document: default
  html_document: default
---
Introduction
========================================================
author: Stacy DeRuiter 
date: 7 August 2017
autosize: true
incremental: true

Why tag?
========================================================
- What questions are best answered using tags? 
- What questions are *you* using tags to answer?

Why tag? A Running Example
========================================================

![DeRuiter et al. 2013](images/DeRuiter2013Head.png)
<img src="images/SOCALBRS-logo.png" width=75>
<img src="images/MOCHA-logo.png" width=350>

Why tag? A Running Example
========================================================
- Study species: *Ziphius cavirostris*
- Tag: DTAG3
![cuviers](images/Cuviers.png)

Why tag? A Running Example
========================================================
Controlled Exposure Experiments (CEEs)

with Mid-frequency Active Sonar (MFAS)
![CEE](images/CEE-scheme.png)

Ethics of tagging 
========================================================
- Can the question be answered with existing data?
- Are simulations a viable alternative?
- Is the tag suitable? 
    - sensors, sampling rates
    - accuracy
    - size 
    - tagging duration
    
Ethics in our example
========================================================
- Lack of existing data for analysis or simulation
- Was tag suitable?
    - What sound did whales receive?
    - Do dive behavior, body movement or foraging behavior indicate response?

DTAG3 Sensors (50-200 Hz)
========================================================
![d3 sensors](images/d3-sensors.png)

DTAG3 Sensors (50-200 Hz)
========================================================
![d3 sensors](images/d3-sensors2.png)

DTAG3 Sensors (50-200 Hz)
========================================================
![d3 sensors](images/d3-sensors3.png)

DTAG3 Sensors (50-200 Hz)
========================================================
![d3 sensors](images/d3-sensors4.png)

Ethics of tagging 2
========================================================
 - Do you need and have a permit?
     - NOAA permits to approach, photograph and tag in SOCAL
 - Do you have IACUC and peer approval?
     - IACUC proposals and many public presentations, consults
     
Ethics of tagging 3
========================================================
 - How will you minimize risk to animals and personnel?
     - Field protocols, sound source shut-down, data recovery
<div align='center'>
![channel islands](images/channel-islands.jpg)
<font size=4> 
<br>(photo from https://www.national-park.com/welcome-to-channel-islands-national-park/)
</font> 
</div>

Ethics of tagging 4
========================================================
- How many animals will you need to tag to answer the question? (TWO?)
- How will you measure responses to tagging (during or after field work)?
- Can you collect and integrate all of the ancillary data needed?

Ancillary data
========================================================
- Visual observations 
- Acoustic tracking
- Visual and radar tracking of vessels in the area
- Photos and video
- Genetics (biopsy, skin sample)
- Life history of tagged whale (photo-id studies)
- Oceanographic measurements (CTD, current, bathymetry)

 Ancillary data challenges
========================================================
- Storage, quality control, archiving (paper? the dreaded spreadsheets?) 
- Accounting for effort
- Collaboration with others in the study area, data sharing
- **Integrating data with different time scales, varying accuracy**

 Ethics and Data-Sharing
========================================================
- How will you analyse the data to address your question? 
- Who else can use the data? 
- When and how will you share the data?
- Does the value of the science merit the abuse?
<div align='center'>
![channel islands](images/narwhal.jpg)
<font size=4> 
<br>(photo from [Dietz et al. 2007, doi.org/10.1186/1472-6785-7-14](https://doi.org/10.1186/1472-6785-7-14))
</font> 
</div>
Note: maybe move this to the very end (earn your coffee examples) and include here the "running example" -- cost (in many senses) per data point?
Types of tag
========================================================
- Short-term (day) to Long-term (year) 
- Attachment: suction cups, bolts, straps, glue...
- Sensors: Geo position, orientation, depth/altitude, sound, video, heart-rate, temperature...
- Archival vs. Telemetry

Trade-offs, Advantages & Disadvantages
========================================================
- Availability of tags & analysis tools
- "Ease" of attachment (for you and animal)
- Record duration vs. data density
- "Ease" of data retrieval

How do you choose a tag type?
========================================================
- What question are you trying to answer? 
- Is your tag appropriate? 
- **You (may have chosen)...**

This workshop: Hi-res movement tags
========================================================
- Typically include:
    - Sensors sampled multiple times per second
    - Accelerometers to measure body posture and sudden movements or changes in speed
    - Magnetometers to measure direction of travel
    - Pressure sensors to measure dive depth in aquatic or marine animals

Hi-Res Movement Tag Examples
========================================================
    list of tags with links/photos here
This workshop: Hi-res movement tags
========================================================
- May include:
    - Speed sensor
    - Gyroscopes (to measure turning rate)
    - Sound sensors
    - Video recorders

Working with tag data
========================================================
*How do we get from A...*
![tagphoto](images/d3.png)
***
*... to B?*
![zc-figure](images/zc-fig.png)

Choose software
========================================================
- Matlab
    - Pros: Broad user base, flexible, *fast* at matrix calculations
    - Cons: Expensive, steep learning curve
- Octave
    - Pros: Free & open source, "almost matlab" now
    - Cons: Basic user interface, steep learning curve
- R/RStudio
    - Pros: Free & open source, pro stats standard, tutorials/resources
    - Cons: Slower (?), steep learning curve

Where's the gradual learning curve?
========================================================

Check out some online learning resources gathered at:

[https://github.com/stacyderuiter/TagTools/wiki/Software](https://github.com/stacyderuiter/TagTools/wiki/Software)

Tag tools help & documentation
========================================================
Learn and contribute at

[http://www.animaltags.org](http://www.animaltags.org)
![animaltags.org](images/animaltags.png)

**It's a wiki - join us!**

Read in data
========================================================
- Tag tools can read in:
    - Raw data from several tag types 
    - archival format netCDF files (<-- our focus)
- NetCDF files (.nc) must be stored locally before reading.
- Assume we have a file stored at C:\\data\\testset1.nc
- R:    

```r
testset1 <- load_nc('C:\data\testset1.nc')
```

- Matlab/Octave:

```r
testset1 = load_nc('C:\data\testset1.nc') ;
```

Calibrate data
========================================================
Still working on this - will be a VERY brief description of what/why, e.g. raw to scientific units, tag to whale frame. Details left for next lecture.

Attach metadata
========================================================
Metadata has at least 2 sources:
- Gleaned automatically from tag data files
- User-provided 

Saving tag metadata to csv (text file)
========================================================
Still working on this one - will include metadata gleaning example (I hope) plus screen shots of Ye Joo's metadata entry tool. Will try to use the "running example"

Archiving data + metadata to netCDF
========================================================
**netCDF format...**
- Developed with NSF funds for geoscience community
- Is flexible, accomodates data and metadata fields
- Allows many user-defined fields
- Supported by well-defined standards and conventions
- *"supports a view of data as a collection of self-describing, portable objects that can be accessed through a simple interface"* (-[NetCDF website](http://www.unidata.ucar.edu/software/netcdf/docs/netcdf_introduction.html))

Exporting data + metadata to archives
========================================================
![atndac](images/atn-dac.png)
<br>[Animal Telemetry Network (ATN) Data Assembly Center (DAC)](https://ioos.noaa.gov/project/atn/#data)

Exporting data + metadata to archives
========================================================
![atndac](images/atn-dac-uc.png)
<br>[Animal Telemetry Network (ATN) Data Assembly Center (DAC)](https://ioos.noaa.gov/project/atn/#data)


Tag tool kit installation in R
========================================================
- In R, all "tools" must be bundled in **packages**.
- To use a package, you must:
    - **Install** the package (one-time-only)
    - **Load** the package (every new R session)
    
Tag tool kit installation in R
========================================================    
Option A) Install "development version" from GitHub

```r
#install.packages('devtools')
devtools::install_github(
  'stacyderuiter/TagTools/R/tagtools')
```

Tag tool kit installation in R
======================================================== 
Option B) Install from your memory stick. In RStudio:
- Select the **Packages** tab in the lower right pane
- Click **Install**
- Choose **Install from package archive file**
- Click **Browse** and navigate to the R tagtools zip file on your memory stick
- Click **Install**!

(Live Demo)
======================================================== 
![zip-install](images/zip-install.png)

Tag tool kit installation in Matlab
========================================================
- Matlab has access to all functions that are:
    - In directories that are on the **Matlab Path**
    - In the user's **current directory** ("Current Folder" in GUI)

Tag tool kit installation in Matlab
========================================================
- Unpack the Matlab tagtools zip file on your computer
- In Matlab, in the **Home** tab, click **Set Path**
- Click **Add with Subfolders** and then select the tagtools directory
- Click **Save** to save the modified path

(Live Demo)
======================================================== 
![mat-path](images/matlab-path.png)

Tag tool kit installation in Octave
========================================================
- Octave has access to all functions that are:
    - In the user's current directory ("File Browser" in GUI)
    - In **packages** that have been
        - **installed** (one-time operation) and
        - **loaded** (every new Octave session)
        
Tag tool kit installation in Octave
========================================================
To install the tag tools package (assuming the Matlab/Octave zip file is stored in F:\\tagtools\\matlab), run:


```r
pkg install tagtools0.0.0.tar.gz
```

Then to load it:


```r
pkg load tagtools
```

Dependencies
========================================================
In Octave, you also need to manually [install and load](https://www.gnu.org/software/octave/doc/interpreter/Installing-and-Removing-Packages.html) the packages:

- netcdf
- signal

If you are online, you can simply run (for example):

```r
pkg install netcdf 
pkg load netcdf
```


And when it all goes wrong?
========================================================
For specific tools, help is only a command away. Example: need help with the function **plott()**?

in Matlab/Octave:

```r
help plott
```

in R:

```r
?plott
```

```
No documentation for 'plott' in specified packages and libraries:
you could try '??plott'
```

Project directory structure - Best practices
========================================================
- As possible, save data, code, and documents in subdirectories of one main project directory
- Document your work:
    - Save files rather than just running code in the console
    - Document your code with comments and explantions
    - Give variables names that are easy to understand
    - Prefer descriptive labels to numeric identifiers
- Consider **Reproducible Research** - code, documentation and report all in one document!
    - In R: [knitr](https://yihui.name/knitr/)
    - In R: [Rmarkdown](http://rmarkdown.rstudio.com/)
    - In Octave/Matlab... ?


Begin analysis? 
========================================================
(Stay tuned...Maybe after a coffee.)

Exercises to earn your coffee
========================================================
**What is wrong (or right) with this picture?**
[coming soon]
- Show screen shots of projects
- metadata file creation by "Homer"
- tags on animals (ethics, tag type, benefits...)
- errors you will see in R/matlab/octave

