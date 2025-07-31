# **Brain template**

An ANTs-based state-of-the-art method for constructing and validating population- and ethnicity-specific brain templates to improve registration in non-Caucasian populations.

<img width="921" height="407" alt="image" src="https://github.com/user-attachments/assets/fb25d258-6732-4794-ae4d-82124b96b1b6" />


## 📋 Overview 
### Part 1. Brain template construction (T1 folder)
#### 1. Preprocessing
   - Performs brain extraction and bias field correction

    
#### 2. Rigid registration
   - Runs rigid registration to standard MNI space (creates initial A0 image)

     
#### 3. Affine registration
   - Applies affine registration using six-parameter transformations (translation, rotation, scaling, shearing, etc.)


#### 4. Nonlinear registration
   - Conducts nonlinear registration for improved alignment through localized deformations

*Note: A bootstrap method was applied to validate the adequacy of the sample size.*

<br><br/>
### Part 2. Validation (Validation folder)
#### 1. Preprocessing 
   - Preprocesses an independent sample (brain extraction & bias field correction)

#### 2. Registration
   - Registers sample data to standard templates (MNI152, CN200, Indian-157, etc.)

#### 3. Calculating Jacobian determinant
   - Calculates Jacobian determinants to assess volume expansion and contraction before and after registration






