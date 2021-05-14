import osxphotos
import datetime

def main():
    photosdb = osxphotos.PhotosDB()
    photos = photosdb.photos(albums=["Hafur_select"])

    # for p in photos:
    #     print(
    #         p.original_filename,
    #         p.description,
    #         p.date.strftime('%Y%m%d')
    #     )


    dest_dir = '/Users/kevin/Documents/python_projects/osxphotosyncer/export/fulls'
    for p in photos:

        if p.hasadjustments:
            if  p.original_filename.lower().endswith('.jpg') or p.original_filename.lower().endswith('.jpeg'):
                p.export(dest_dir, p.date.strftime('%Y%m%d') + '_' + p.description + '.jpg', edited=True, use_photos_export=True)
            else:
                p.export(dest_dir, p.date.strftime('%Y%m%d') + '_' + p.description + '.HEIC', edited=True, use_photos_export=True)
        else:
            if p.original_filename.lower().endswith('.jpg') or p.original_filename.lower().endswith('.jpeg'):
                p.export(dest_dir, p.date.strftime('%Y%m%d') + '_' + p.description + '.jpg', use_photos_export=True)
            else:
                p.export(dest_dir, p.date.strftime('%Y%m%d') + '_' + p.description + '.HEIC', use_photos_export=True)


if __name__ == "__main__":
    main()
