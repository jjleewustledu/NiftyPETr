#! /opt/conda/bin/python

if __name__ == '__main__':
    import argparse

    p = argparse.ArgumentParser(description='reconstruction manages NiftyPET reconstructions')
    p.add_argument('-p', '--prefix',
                   metavar='/path/to/TRACER_DT1234566790-Converted-NAC',
                   required=True,
                   help='location containing tracer raw data')
    args = p.parse_args()
    print("echo_args.args.prefix:  " + args.prefix)
    
