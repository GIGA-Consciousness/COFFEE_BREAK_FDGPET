function coivox = nii_setOriginCOM(vols)

%Sets position and orientation of input image(s) to match SPM's templates
%  SPM's normalize function uses the origin as a starting estimate
%  This script provides a robust estimate for the origin.
%  This is particularly important for CT, where initial origin is relative
%  to the table, not to the scanner isocenter, whereas SPM assumes the
%  origin is near the anterior commisure.
% vols : images to reorient, assumed to be from same individual and session.
%        origin estimated from first image and applied to others. For 4D
%        files (e.g. fMRI sessions) you only specify the file name, with
%        the estimate applied to all volumes
% modality: imaging modality, where 1=T1, 2=T2, 3=CT, 4=fMRI(T2*)
%
%Examples
%  nii_setOrigin('T1.nii',1);
%  nii_setOrigin(strvcat('T1.nii','fMRI.nii'),1); %estimated on T1, applied to both

%declaring useful variables
global subj_code
dir_dicom=pwd;
renamedCOUNTfile=strcat(dir_dicom,'/','counts_',subj_code,'.nii');

spm_jobman('initcfg');
if ~exist('vols','var') %no files specified
	vols=renamedCOUNTfile;
end;
coivox = ones(4,1);
if ~exist('vols','var') %no files specified
 vols=renamedCOUNTfile;
end
%vols = vol1OnlySub(vols); %only process first volume of 4D datasets...
[pth,nam,ext, ~] = spm_fileparts(deblank(vols(1,:))); %extract filename
fname = fullfile(pth,[nam ext]); %strip volume label
%report if filename does not exist...
if (exist(fname, 'file') ~= 2) 
 	fprintf('%s set origin error: unable to find image %s.\n',mfilename,fname);
	return;  
end;
hdr = spm_vol([fname,',1']); %load header 
img = spm_read_vols(hdr); %load image data
img = img - min(img(:));
img(isnan(img)) = 0;
%find center of mass in each dimension (total mass divided by weighted location of mass
% img = [1 2 1; 3 4 3];
sumTotal = sum(img(:));
coivox(1) = sum(sum(sum(img,3),2)'.*(1:size(img,1)))/sumTotal; %dimension 1
coivox(2) = sum(sum(sum(img,3),1).*(1:size(img,2)))/sumTotal; %dimension 2
coivox(3) = sum(squeeze(sum(sum(img,2),1))'.*(1:size(img,3)))/sumTotal; %dimension 3
XYZ_mm = hdr.mat * coivox; %convert from voxels to millimeters
fprintf('%s center of brightness differs from current origin by %.0fx%.0fx%.0fmm in X Y Z dimensions\n',fname,XYZ_mm(1),XYZ_mm(2),XYZ_mm(3)); 
for v = 1:   size(vols,1) 
    fname = deblank(vols(v,:));
    if ~isempty(fname)
        [pth,nam,ext, ~] = spm_fileparts(fname);
        fname = fullfile(pth,[nam ext]); 
        hdr = spm_vol([fname ',1']); %load header of first volume 
        fname = fullfile(pth,[nam '.mat']);
        if exist(fname,'file')
            destname = fullfile(pth,[nam '_old.mat']);
            copyfile(fname,destname);
            fprintf('%s is renaming %s to %s\n',mfilename,fname,destname);
        end
        hdr.mat(1,4) =  hdr.mat(1,4) - XYZ_mm(1);
        hdr.mat(2,4) =  hdr.mat(2,4) - XYZ_mm(2);
        hdr.mat(3,4) =  hdr.mat(3,4) - XYZ_mm(3);
        spm_create_vol(hdr);
        if exist(fname,'file')
            delete(fname);
        end
    end
end%for each volume

